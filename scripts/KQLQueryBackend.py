import os
import pandas
from ollama import ResponseError
from RAGParameters import Parameters

from concurrent.futures import ThreadPoolExecutor

from langchain_ollama import OllamaEmbeddings
from langchain_ollama.llms import OllamaLLM

from langchain_core.documents import Document
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.prompts import ChatPromptTemplate, PromptTemplate

from langchain_community.document_loaders import DirectoryLoader, TextLoader

from langchain_text_splitters import RecursiveCharacterTextSplitter
from langchain_classic.retrievers import MultiQueryRetriever

from langchain_chroma import Chroma


class KQLQueryHandler:
    def __init__(self, kqlParameters):
        self.embeddings = OllamaEmbeddings(
            model=kqlParameters.embedding_model, keep_alive=-1
        )
        self.model = OllamaLLM(model=kqlParameters.ollama_model, keep_alive=-1)

        self.kqlParameters = kqlParameters
        # self.kqlParameters.embeddings_save_dir = os.path.join("chroma_databases", kqlParameters.embedding_model.replace(":", "_"))
        self.kqlParameters.embeddings_save_dir = os.path.join(".", "chroma_ecs_db")
        self.first_llm_setup = not os.path.exists(
            self.kqlParameters.embeddings_save_dir
        )

    # Creates a Vector Database from given documents
    def CreateMarkdownVectorDB(self):
        self.kqlParameters.embeddings_save_dir = os.path.join(".", "chroma_ecs_db")
        self.first_llm_setup = not os.path.exists(
            self.kqlParameters.embeddings_save_dir
        )

        vector_db = Chroma(
            embedding_function=self.embeddings,
            persist_directory=self.kqlParameters.embeddings_save_dir,
            collection_name="elastic_ecs_docs",
        )

        if vector_db._collection.count() == 0:
            print("NO CHROMA DATABASE EXISTS, Creating one!")
            DOCS_DIRECTORY = os.path.join(".", "ecs-corpus")
            loader = DirectoryLoader(
                DOCS_DIRECTORY,
                glob="**/*.md",
                loader_cls=TextLoader,
                loader_kwargs={"encoding": "utf-8"},
                use_multithreading=True,
                show_progress=True,
            )

            documents = loader.load()
            print(f"Loaded {len(documents)} markdown files.")

            text_splitter = RecursiveCharacterTextSplitter(
                chunk_size=1500,
                chunk_overlap=150,
                separators=["\n## ", "\n### ", "\n\n", "\n", " ", ""],
            )
            
            chunked_docs = text_splitter.split_documents(documents)
            print(f"Split into {len(chunked_docs)} chunks.")

            BATCH_SIZE = 100
            batches = [
                chunked_docs[i : i + BATCH_SIZE]
                for i in range(0, len(chunked_docs), BATCH_SIZE)
            ]

            def add_batch(batch):
                vector_db.add_documents(documents=batch)

            with ThreadPoolExecutor(max_workers=5) as executor:
                list(executor.map(add_batch, batches))

            print(f"Added {len(chunked_docs)} chunks to vector store.")

        return vector_db

    # Creates a retriever using a given Vector Database
    def CreateRetriever(self, vector_db):

        QUERY_PROMPT = PromptTemplate(
            input_variables=["question"],
            template="""You are an AI language model assistant. Your task is to generate two
            different versions of the given user question to retrieve relevant documents from
            a vector database. By generating multiple perspectives on the user question, your
            goal is to help the user overcome some of the limitations of the distance-based
            similarity search. Provide these alternative questions separated by newlines. 
            Original question: {question}""",
        )

        # Bind the prompt and the retriever together
        # retriever = MultiQueryRetriever.from_llm(retriever=vector_db.as_retriever(), llm=self.model, prompt=QUERY_PROMPT)

        # Alternate Method Of Retrieval
        retriever = vector_db.as_retriever(
    search_type="mmr",
    search_kwargs={
        "k": 5,
        "fetch_k": 15,
        "lambda_mult": 0.5,
    }
)


     

# )
        return retriever

    # Prepares a chain for future execution
    def CreateChain(self):
        template = """
You are given reference documentation describing available log fields:

{context}

Convert the scenario below into a single KQL (Kibana Query Language) query using only fields present in the documentation above.

IMPORTANT: Always use the full, exact field name as it appears after "Field:" in the documentation — never shorten it to just the field set name.
Correct: user.name: "John"
Incorrect: user: "John"
Correct: host.name: "SYS-01"
Incorrect: host: "SYS-01"

Scenario: {question}

Respond with ONLY the raw KQL query. No JSON. No explanations. No markdown or code blocks. No labels like "Query:". Your entire response must be a single line containing nothing but the KQL query itself.
"""
        prompt = ChatPromptTemplate.from_template(template)
        chain = prompt | self.model
        return chain

    # Invokes all methods from class in sequential order for easy method calling in order to receive a response for a given question
    def AskQuestion(self, question):
        if (
            self.kqlParameters.embedding_model == "None"
            or self.kqlParameters.ollama_model == "None"
        ):
            raise ResponseError(
                "Please Set Both Embedding Model and LLM Model Before Querying"
            )
        # documents, ids = self.CreateCSVDocuments(self.kqlParameters.doc_path)

        # vector_db = self.CreateVectorDB(documents, ids)
        vector_db = self.CreateMarkdownVectorDB()

        data = retriever = self.CreateRetriever(vector_db)

        chain = self.CreateChain()

        context = retriever.invoke(question)
        response = chain.invoke({"context": context, "question": question})
        return response
