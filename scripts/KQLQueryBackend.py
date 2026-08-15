import os
import glob

from ollama import ResponseError
from RAGParameters import Parameters

from langchain_ollama import OllamaEmbeddings
from langchain_ollama.llms import OllamaLLM

from langchain_core.documents import Document
from langchain_core.prompts import ChatPromptTemplate

from langchain_text_splitters import RecursiveCharacterTextSplitter
from langchain_chroma import Chroma

from docling.document_converter import DocumentConverter

class KQLQueryHandler:
    def __init__(self, kqlParameters):
        # Setup Ollama Embedding Model
        self.embeddings = OllamaEmbeddings(
            model=kqlParameters.embedding_model, keep_alive=-1
        )

        # Setup Ollama Generation Model
        self.model = OllamaLLM(
            model=kqlParameters.ollama_model,
            keep_alive=-1, 
            num_ctx=(4096 * 2),
            temperature=0
        )

        # Setting Parameters For AI
        self.kqlParameters = kqlParameters
        self.kqlParameters.embeddings_save_dir = os.path.join(".", "chroma_ecs_db")
        self.first_llm_setup = not os.path.exists(
            self.kqlParameters.embeddings_save_dir
        )

    # Method That Creates A Vector DB With Markdown Files
    def CreateMarkdownVectorDB(self):
        self.kqlParameters.embeddings_save_dir = os.path.join(".", "chroma_ecs_db")
        
        vector_db = Chroma(
            embedding_function=self.embeddings,
            persist_directory=self.kqlParameters.embeddings_save_dir,
            collection_name="elastic_ecs_docs",
        )

        # If There Is NO Active Vector DB, Create One
        if vector_db._collection.count() == 0:
            print("NO CHROMA DATABASE EXISTS, Creating one!")
            DOCS_DIRECTORY = os.path.join(".", "ecs-corpus")

            # Only Fetch Markdown Files
            file_paths = glob.glob(os.path.join(DOCS_DIRECTORY, "**/*.md"), recursive=True)
            converter = DocumentConverter()

            conv_results = converter.convert_all(file_paths)

            documents = []
            for result in conv_results:
                if result.document:
                    md_content = result.document.export_to_markdown()
                    metadata = {"source": str(result.input.file)}
                    documents.append(
                        Document(page_content=md_content, metadata=metadata)
                    )

            print(f"Loaded {len(documents)} markdown files.")

            text_splitter = RecursiveCharacterTextSplitter(
                        separators=[
                            "\n---\n\n## ",  
                            "\n## ",          
                            "\n",             
                            ""                
                        ],
                        chunk_size=1500,     
                        chunk_overlap=0,
                        is_separator_regex=False
                    )

            chunked_docs = text_splitter.split_documents(documents)
            print(f"Split documents into {len(chunked_docs)} chunks.")

            # Add Chunks Into Vector DB in Batches (Prevents Crashing)
            BATCH_SIZE = 100
            batches = [
                chunked_docs[i : i + BATCH_SIZE]
                for i in range(0, len(chunked_docs), BATCH_SIZE)
            ]

            print(f"Adding {len(chunked_docs)} chunks to vector database...")
            for batch in batches:
                vector_db.add_documents(documents=batch)

            print("Finished adding documents to vector database.")

        return vector_db

    # Method That Creates A Retriever (Turning User Quesiton Into Embeddings)
    def CreateRetriever(self, vector_db):
        retriever = vector_db.as_retriever(
            search_type="similarity",
            search_kwargs={
                "k": 8
            }
        )
        return retriever

    # Method That Creates An Execution Chain For The Execution Of The Backend
    def CreateChain(self):
        # Strict enforcement template to stop field hallucination
        template = """
        You are a strict Elastic Common Schema (ECS) mapping engine. 

        ====== CONTEXT ==========
        Base your ANSWERS ON THIS INFORMATION ONLY (IF NEEDED, OR ELSE, Only use your knowledge)!

        {context}
        =========================

        This is the user's Scenario/Question: {question}


        Double check to ensure you did not make this field up (ALWAYS cite sources of a field (I need the snippet of it in the "ecs.masterfieldslist.md" file). You are allowed to use the actual field and tell the user to find the specific value themselves, but this is non negotiable)
        In addition, If you are having trouble/to provide more clarity, attempt to utlilize synonyms of the question in order to better craft fields
        NEVER EVER Take only parts of an entire field. YOU MUST TAKE WHOLE FIELD (e.g if you see a field of format "field_set1.field1.field2. YOU NEVER truncate it to "field_set.field2". You must keep field3 WITH Decimals between it.
        Ensure that you do not confuse the ECS Section as being part of the whole field. For example, your response of "The relevant fields are typically found under the network section of the Elastic Common Schema (ECS)". In this, you put that the whole query was "network.source.port". THIS IS WRONG!You must omit the section "network" and just return "source.port"
        An Additional Rule Is That YOUR Crafted Query MUST be a valid query for putting in the search bar directly + You will only put the minimum fields necessary to specifically go with your request.
        """
        prompt = ChatPromptTemplate.from_template(template)
        chain = prompt | self.model
        return chain

    # Method That Takes In A User's Question/Prompt And Returns A Response
    def AskQuestion(self, question):
        if (
            self.kqlParameters.embedding_model == "None"
            or self.kqlParameters.ollama_model == "None"
        ):
            raise ResponseError(
                "Please Set Both Embedding Model and LLM Model Before Querying"
            )

        vector_db = self.CreateMarkdownVectorDB()
        retriever = self.CreateRetriever(vector_db)
        chain = self.CreateChain()
        context = retriever.invoke(question)
        response = chain.invoke({"context": context, "question": question})

        return response