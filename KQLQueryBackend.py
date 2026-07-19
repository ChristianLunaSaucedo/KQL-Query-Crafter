from langchain_ollama import OllamaEmbeddings
from langchain_chroma import Chroma
from langchain_core.documents import Document
import os
import pandas
from langchain_ollama.llms import OllamaLLM
from langchain_core.prompts import ChatPromptTemplate

from RAGParameters import Parameters

class KQLQueryHandler():
    def __init__(self):
        self.embeddings = OllamaEmbeddings(model=Parameters.embedding_model)
        self.model = OllamaLLM(model=Parameters.ollama_model)
        
        self.first_llm_setup = not os.path.exists(Parameters.embeddings_save_dir)
        

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
    
    def CreateVectorDB(self, documents, ids):
        vector_db = Chroma(
            collection_name="restaurant_reviews",
            persist_directory=Parameters.embeddings_save_dir,
            embedding_function=self.embeddings,
        )

        if self.first_llm_setup:
            vector_db.add_documents(documents=documents, ids=ids)
        return vector_db
    
    def CreateRetriever(self, vector_db):
        retriever = vector_db.as_retriever(
            search_kwargs={"k": 8}
        )
        return retriever
    
    def CreateChain(self):
        template = Parameters.template
        prompt = ChatPromptTemplate.from_template(template)
        chain = prompt | self.model 
        return chain
    
    def AskQuestion(self, question):
        documents, ids = self.CreateCSVDocuments(Parameters.doc_path)

        vector_db = self.CreateVectorDB(documents, ids)        
        
        retriever = self.CreateRetriever(vector_db)

        chain = self.CreateChain()

        context = retriever.invoke(question)
        response = chain.invoke({"context": context, "question": question})
        return response
    