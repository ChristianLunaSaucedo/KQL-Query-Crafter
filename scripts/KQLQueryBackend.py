import os
import pandas
from ollama import ResponseError
from RAGParameters import Parameters

from langchain_ollama import OllamaEmbeddings
from langchain_ollama.llms import OllamaLLM

from langchain_core.documents import Document
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.prompts import ChatPromptTemplate, PromptTemplate

from langchain_classic.retrievers import MultiQueryRetriever

from langchain_chroma import Chroma

class KQLQueryHandler():
    def __init__(self, kqlParameters):
        self.embeddings = OllamaEmbeddings(model=kqlParameters.embedding_model, keep_alive=-1)
        self.model = OllamaLLM(model=kqlParameters.ollama_model, keep_alive=-1)
        
        self.kqlParameters = kqlParameters
        self.kqlParameters.embeddings_save_dir = os.path.join("chroma_databases", kqlParameters.embedding_model.replace(":", "_"))
        self.first_llm_setup = not os.path.exists(self.kqlParameters.embeddings_save_dir)


    # Creates Documents From CSV File (Can be swapped out for Other Types Of Files)
    def CreateCSVDocuments(self, doc_path):
        csv_data = pandas.read_csv(doc_path)
        documents = []
        ids = []

        if self.first_llm_setup:
            for id, row in csv_data.iterrows():
                document = Document(
                page_content=f"""
            Field: {row['Field']}

            Field Set: {row['Field_Set']}

            Type: {row['Type']}

            Description:
            {row['Description']}

            Example:
            {row['Example']}
            """.strip(),
                metadata={
                    "field": row["Field"],
                    "field_set": row["Field_Set"],
                    "type": row["Type"]
                },
                id=str(id)
            )
                ids.append(str(id))
                documents.append(document)
        return documents, ids

     def CreateMarkdownVectorDB(self):
        DOCS_DIRECTORY = os.path.join(".", "ecs-corpus")
        loader = DirectoryLoader(
        DOCS_DIRECTORY,
        glob="**/*.md",             # Recursively find all .md files
        loader_cls=TextLoader,       # Use simple text loading for raw Markdown
        loader_kwargs={"encoding": "utf-8"}
        )

        documents = loader.load()
        print(f"Loaded {len(documents)} markdown files.")

        # 3. Split large Markdown documents into smaller chunks
        # Crucial for vector search so context stays focused and fits within LLM context windows
        text_splitter = RecursiveCharacterTextSplitter(
            chunk_size=7000,           # Character limit per chunk
            chunk_overlap=200,         # Overlap ensures context isn't cut awkwardly at boundaries
            separators=["\n## ", "\n### ", "\n\n", "\n", " ", ""] # Respects Markdown headers!
        )

        chunked_docs = text_splitter.split_documents(documents)
        print(f"Split into {len(chunked_docs)} chunks.")

        vector_db = Chroma.from_documents(
            documents=chunked_docs,
            embedding=self.embeddings,
            persist_directory="./chroma_ecs_db",
            collection_name="elastic_ecs_docs"
        )
        return vector_db


    # Creates a Vector Database from given documents
    def CreateVectorDB(self, documents, ids):
        vector_db = Chroma(
            collection_name="ecs_fields",
            persist_directory=self.kqlParameters.embeddings_save_dir,
            embedding_function=self.embeddings,
        )

        if self.first_llm_setup:
            vector_db.add_documents(documents=documents, ids=ids)
        return vector_db

    # Creates a retriever using a given Vector Database
    def CreateRetriever(self, vector_db):

        QUERY_PROMPT = PromptTemplate(
            input_variables=["question"], 
            template="""You are an AI language model assistant. Your task is to generate three
            different versions of the given user question to retrieve relevant documents from
            a vector database. By generating multiple perspectives on the user question, your
            goal is to help the user overcome some of the limitations of the distance-based
            similarity search. Provide these alternative questions separated by newlines. 
            Original question: {question}"""
        )

        # Bind the prompt and the retriever together
        retriever = MultiQueryRetriever.from_llm(retriever=vector_db.as_retriever(), llm=self.model, prompt=QUERY_PROMPT)

        # Alternate Method Of Retrieval
        # retriever = vector_db.as_retriever(
        #     search_kwargs={"k": 8}
        # )

        return retriever

    # Prepares a chain for future execution
    def CreateChain(self):
        template = self.kqlParameters.template
        prompt = ChatPromptTemplate.from_template(template)
        chain = prompt | self.model 
        return chain

    # Invokes all methods from class in sequential order for easy method calling in order to receive a response for a given question
    def AskQuestion(self, question):
        if(self.kqlParameters.embedding_model == "None" or self.kqlParameters.ollama_model == "None"):
            raise ResponseError("Please Set Both Embedding Model and LLM Model Before Querying")
        documents, ids = self.CreateCSVDocuments(self.kqlParameters.doc_path)

        vector_db = self.CreateVectorDB(documents, ids)   
        
        retriever = self.CreateRetriever(vector_db)

        chain = self.CreateChain()

        context = retriever.invoke(question)
        response = chain.invoke({"context": context, "question": question})
        return response
    
