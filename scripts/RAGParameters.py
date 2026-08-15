# A class for simply holding parameters for Backend RAG System
class Parameters():
        
        def __init__(self):
                # Replace This With Preferred Embedding Model
                self.embedding_model = "hf.co/SandLogicTechnologies/granite-embedding-311m-multilingual-r2-GGUF:IQ4_NL"

                self.embeddings_save_dir = "N/A"

                # Replace Model in the 'Modelfile.txt' with preferred Generation Model
                self.ollama_model = "kibana-ai"
                
        
