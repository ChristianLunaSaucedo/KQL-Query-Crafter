import ollama
import os
from ollama import ResponseError
from datetime import datetime

from KQLQueryBackend import KQLQueryHandler
from RAGParameters import Parameters

from PyQt6.QtGui import QGuiApplication
from PyQt6.QtCore import QObject, pyqtSlot as Slot, pyqtSignal as Signal, QRunnable, QThreadPool

# Class Used To Manage Main QML/Python Communication
class SystemController(QObject):
    
    # Signals To Send To QML
    query_started = Signal()
    query_finished = Signal(str, str, bool)
    send_response = Signal(str, str, bool)

    send_existing_model = Signal(str)

    def __init__(self):
        super().__init__()

        # Setting Up System Controller LLM
        self.kqlParameters = Parameters()
        self.kql_query_handler = KQLQueryHandler(self.kqlParameters)

    # Method that sends a query to backend LLM and sends response to frontend (Optimized By Making It a Multi-Threaded Process)
    @Slot(str)
    def QueryPrompt(self, textToQuery):
        self.query_started.emit()

        # A Class That Runs On Threads
        class Task(QRunnable):
            def __init__(task_self, textToQuery, kql_query_handler):
                super().__init__()
                task_self.textToQuery = textToQuery
                task_self.kql_query_handler = kql_query_handler

                # A helpful message to avoid confusion when using a new embedding model for the first time
                # if self.kql_query_handler.first_llm_setup and self.kqlParameters.embedding_model != "None":
                #     self.send_response.emit("First Time Using Embedding Model Detected", "Please Run A Query And Restart The Application To Resolve (If Valid Model)", True)
                    
            def run(task_self):
                print("Querying Prompt: ", task_self.textToQuery)

                # Sends response from llm to frontend QML (Error Sent If Failed)
                try:
                    print("Started Query @: ", datetime.now())
                    response = task_self.kql_query_handler.AskQuestion(task_self.textToQuery)
                    print("Finished Query @: ", datetime.now())
                    print("GOT A Query FROM THREAD: ", response)
                    self.query_finished.emit(task_self.textToQuery, response, False)
                except ResponseError as e:
                    self.query_finished.emit(task_self.textToQuery, "Error", True)
                    print("FAILED! ", e)

                

        # Spawn Task On New Thread
        task = Task(textToQuery, self.kql_query_handler)
        QThreadPool.globalInstance().start(task)
        print("Spawned KQL Query Thread")

    # Method that is called in the beginning of app setup to fetch all existing ollama models on host and sends to frontend
    @Slot()
    def FetchLLMList(self):
        modelsList = ollama.list()['models']
        
        for model in modelsList:
            modelName = model['model']

            self.send_existing_model.emit(modelName)

    # Method that is called to easily copy a text to a host's clipboard 
    @Slot(str)
    def CopyToClipboard(self, textToCopy):
        clipboard = QGuiApplication.clipboard()
        clipboard.setText(textToCopy)
        print("Copied Text To Clipboard: ", textToCopy)

    # Method that is called to update the backend generation model from interactions in the frontend QML files
    @Slot(str)
    def UpdateGenerationLLM(self, newModel):
        print("Swapped Generation Model From ",self.kqlParameters.ollama_model, " To: ", newModel)
        # Update Parameters 
        self.kqlParameters.ollama_model = newModel
        self.kql_query_handler = KQLQueryHandler(self.kqlParameters)

    # Method that is called to update the backend embedding model from interactions in the frontend QML files
    @Slot(str)
    def UpdateEmbeddingModel(self, newModel):
        print("Swapped Embedding Model From ",self.kqlParameters.embedding_model, " To: ", newModel)
        # Update Parameters 
        self.kqlParameters.embedding_model = newModel
        self.kql_query_handler = KQLQueryHandler(self.kqlParameters)
        
        