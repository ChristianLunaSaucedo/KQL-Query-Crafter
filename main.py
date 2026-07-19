import sys, os
from PyQt6.QtGui import QGuiApplication
from PyQt6.QtQml import QQmlApplicationEngine
from PyQt6.QtCore import QObject, pyqtSlot as Slot
from RAGBackend import RAGSystem

doc_path = "D:\\Coding\\PythonProjects\\RAGSystem\\data\\ECS_RAG_Formatted.pdf"
model = "qwen2.5-coder:7b"

embedding_model = "nomic-embed-text"
embedding_directory = "saved_embeddings"
embedding_collection_name = "simple-rag"

chunk_size = 1500
chunk_overlap = 150


class SystemController(QObject):
    @Slot(str)
    def CopyToClipboard(self, textToCopy):
        clipboard = QGuiApplication.clipboard()
        clipboard.setText(textToCopy)
        print("Copied Text To Clipboard: ", textToCopy)
        pass
    
    @Slot(str, result=str)
    def QueryPrompt(self, textToQuery):
        print("Querying Prompt: ", textToQuery)

        rag_system = RAGSystem()
        data = rag_system.LoadPDFFile(doc_path)
        chunks = rag_system.SplitDocumentIntoChunks(data, chunk_size, chunk_overlap)
        vector_db = rag_system.CreateVectorDB(chunks)
        chain = rag_system.SetupLLM(vector_db)
        
        response = rag_system.AskQuestion(chain, textToQuery)
        print("RESULTING QUERY FROM PYTHON: ", response)
        return response

if __name__ == "__main__":
    # Initialize the application
    app = QGuiApplication(sys.argv)
    systemController = SystemController()

    # Create the QML application engine
    engine = QQmlApplicationEngine()
    engine.quit.connect(app.quit)

    # Connecting Python & QML
    engine.rootContext().setContextProperty("systemController", systemController)

    # Load the QML file
    os.environ["QT_QUICK_CONTROLS_STYLE"] = "Fusion"

    engine.load(".\\qml\\main.qml")
    


    # Start the event loop
    sys.exit(app.exec())
