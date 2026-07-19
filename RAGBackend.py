from langchain_unstructured import UnstructuredLoader
from langchain_ollama import OllamaEmbeddings
from langchain_text_splitters import RecursiveCharacterTextSplitter
from langchain_chroma.vectorstores import Chroma
from langchain_community.vectorstores.utils import filter_complex_metadata

from langchain_classic.retrievers import MultiQueryRetriever
from langchain_core.prompts import ChatPromptTemplate, PromptTemplate
from langchain_core.output_parsers import StrOutputParser
from langchain_ollama import ChatOllama
from langchain_core.runnables import RunnablePassthrough
from langchain_community.document_loaders import PyPDFLoader

import ollama


doc_path = "D:\\Coding\\PythonProjects\\RAGSystem\\data\\ECS_RAG_Formatted.pdf"
model = "qwen2.5-coder:7b"

embedding_model = "nomic-embed-text"
embedding_directory = "saved_embeddings"
embedding_collection_name = "simple-rag"

chunk_size = 1500
chunk_overlap = 150

class RAGSystem():
    def __init__(self):
        pass
    def LoadPDFFile(self, doc_path):
        if doc_path.strip():
            loader = PyPDFLoader(doc_path)
            data = loader.load()
            # data = filter_complex_metadata(data)
            print("Done loading")
            return data
        else:
            print("Please Enter A PDF")
            return data
    
    def LoadSavedEmbeddings(self):
        vector_db = Chroma(
        persist_directory=embedding_directory,
        embedding_function=OllamaEmbeddings(
        model=embedding_model,
        collection_name=embedding_collection_name)
    )
    
    # Only USED IF FOR DYNAMIC PDF
    def SplitDocumentIntoChunks(self, data, chunk_size=300, chunk_overlap=50):
       text_splitter = RecursiveCharacterTextSplitter(chunk_size=chunk_size, chunk_overlap=chunk_overlap)
       chunks = text_splitter.split_documents(data)
       print(f"Chunks: {len(chunks)}")
       print("done splitting")

    #    print(f"Number of chunks: {len(chunks)}")
       print(f"Example chunk: {chunks[0].page_content}")        
       return chunks
    
    # Only USED IF FOR DYNAMIC PDF
    def CreateVectorDB(self, chunks):
        # 4) Retrieval
        # ollama.pull(embedding_model) # ollama pull nomic-embed-text

        vector_db = Chroma.from_documents(
            documents=chunks,
            embedding=OllamaEmbeddings(model=embedding_model),
            collection_name=embedding_collection_name, # This is a generic name
            persist_directory=embedding_directory
        )

        print("done adding to vector database...")
        return vector_db
    
    def SetupLLM(self, vector_db):
        
        # Set the model to use
        llm = ChatOllama(model=model)

        # prepares a prompt to send to llm (FOR BEHAVIOR REASONS + QUESTION POSSIBILITIES)
        QUERY_PROMPT = PromptTemplate(
            input_variables=["question"], # This is must match what is in the template
            template="""You are an AI language model assistant. Your task is to generate three
            different versions of the given user question to retrieve relevant documents from
            a vector database. By generating multiple perspectives on the user question, your
            goal is to help the user overcome some of the limitations of the distance-based
            similarity search. Provide these alternative questions separated by newlines.
            Original question: {question}"""
        )
        # Bind the prompt and the retriever together
        # retriever = MultiQueryRetriever.from_llm(retriever=vector_db.as_retriever(), llm=llm, prompt=QUERY_PROMPT)
        retriever = vector_db.as_retriever(search_kwargs={"k": 8})

        # RAG prompt 
        template = """You are an expert on Kibana Query Language (KQL).
Your sole task is to translate the user's scenario into a syntactically correct KQL query based ONLY on the provided context.

[CONTEXT]
{context}

[STRICT KQL SYNTAX RULES]
1. FIELD EXISTENCE: Check if a field exists using `field: *`. Example: `http.request.method: *`
2. VALUE MATCHING: 
   - Non-text/Exact fields (keyword, IP, numbers, bool, status codes): Use `field: value`. String values with spaces or special characters MUST be wrapped in double quotes. Example: `client.ip: "10.0.0.5"`
   - Text fields (phrases where word order matters): Wrap phrases in double quotes. Example: `http.request.body.content: "null pointer"`
3. CHAR ESCAPING: Escape special characters `\\ ( ) : < > " *` with a backslash if NOT wrapped in double quotes. Example: `http.request.referrer: https\\://url`
4. RANGES: Use `<`, `<=`, `>`, `>=`. Combine multiple ranges using `AND`. Example: `http.response.bytes > 10000 AND http.response.bytes <= 20000`. Date math example: `@timestamp < now-2w`
5. WILDCARDS: Use `*` to match trailing patterns. Example: `http.response.status_code: 4*` (No leading wildcards). For prefix/partial matches, use the wildcard suffix: `field: prefix*`.
6. LOGIC & OPERATORS: Use `NOT`, `AND`, `OR` (case-insensitive, but uppercase preferred). If the user implies multiple conditions, translate "and" to the uppercase "AND" operator, and "or" to the uppercase "OR" operator.
7. PRECEDENCE & SHORTHAND: Use parentheses to enforce logic order or map multiple values to one field. Example: `http.request.method: (GET OR POST OR DELETE)`. If a single field can match multiple values, use KQL shorthand grouping: `field: (value1 OR value2 OR value3)`. Keep Boolean operator precedence in mind and use parentheses `()` to group complex logic.
8. MULTI-FIELD WILDCARDS: Query subfields using `*`. Example: `datastream.*: logs`
9. FIELD COMPLETENESS: Ensure that you always select an entire Field: Keyword. Not just partial, unless that is actually what the user wants.

[STMT RULES]
1. Exact string matches must be wrapped in double quotes: `field: "value"`.
2. Numerical or keyword values do not require quotes unless they contain special characters or spaces.
3. To check if a field exists, use the wildcard operator: `field: *`.

[CRITICAL OUTPUT CONSTRAINTS]
- THOSE SHOULD BE THE ONLY WORDS COMING OUT OF YOU! 
- Output ONLY the final raw KQL query string. THE ABSOLUTE FINAL ANSWER WILL JUST BE THE QUERY ALONE (NOTHING OTHER THAN THE QUERY). ENSURE THE OUTPUT QUERY IS ALONE WITHOUT ANY QUOTES. NO ```

- Do NOT include markdown code blocks (e.g., ```kql).
- Do NOT use backticks around the final query output.
- Do NOT include introductory sentences (e.g., "Here is your query:"), explanations, or conversational filler.


[USER INPUTS]
Question: {question}
Answer:"""

        prompt = ChatPromptTemplate.from_template(template)

        chain = (
            {"context": retriever, "question": RunnablePassthrough()}
            | prompt
            | llm
            | StrOutputParser()
        )
        return chain
    
    def AskQuestion(self, chain, question):
        res = chain.invoke(question)
        return str(res)
    



# TESTING NOW CODE







