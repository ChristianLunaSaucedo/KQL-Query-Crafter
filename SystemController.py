import sys, os, ollama

from ollama import ResponseError
from langchain_ollama.llms import OllamaLLM


from KQLQueryBackend import KQLQueryHandler
from RAGParameters import Parameters

from PyQt6.QtGui import QGuiApplication
from PyQt6.QtQml import QQmlApplicationEngine
from PyQt6.QtCore import QObject, pyqtSlot as Slot, pyqtSignal as Signal, QRunnable, QThreadPool, QSettings
from ollama import ResponseError

class SystemController(QObject):
    
    # Signals To Send To QML
    query_started = Signal()
    query_finished = Signal(str, str)

    send_existing_model = Signal(str)

    def __init__(self):
        super().__init__()

        # Querying
        self.kqlParameters = Parameters()
        self.kql_query_handler = KQLQueryHandler(self.kqlParameters)

    @Slot(str)
    def QueryPrompt(self, textToQuery):
        self.query_started.emit()

        # A Class That Runs On Threads
        class Task(QRunnable):
            def __init__(task_self, textToQuery, kql_query_handler):
                super().__init__()
                task_self.textToQuery = textToQuery
                task_self.kql_query_handler = kql_query_handler
                    
            def run(task_self):
                print("Querying Prompt: ", task_self.textToQuery)
                
                try:
                    response = task_self.kql_query_handler.AskQuestion(task_self.textToQuery)
                    print("GOT A Query FROM THREAD: ", response)
                    self.query_finished.emit(task_self.textToQuery, response)
                except ResponseError as e:
                    self.query_finished.emit(task_self.textToQuery, "Error")
                    print("FAILED!")

                

        # Spawn Task On New Thread
        task = Task(textToQuery, self.kql_query_handler)
        QThreadPool.globalInstance().start(task)
        print("Spawned KQL Query Thread")
    
    @Slot()
    def FetchLLMList(self):
        modelsList = ollama.list()['models']
        if len(modelsList) == 0:
            self.send_existing_model.emit("NONE")
            return
            
        for model in modelsList:
            modelName = model['model']


            self.send_existing_model.emit(modelName)

        
    @Slot(str)
    def CopyToClipboard(self, textToCopy):
        clipboard = QGuiApplication.clipboard()
        clipboard.setText(textToCopy)
        print("Copied Text To Clipboard: ", textToCopy)
    
    @Slot(str)
    def UpdateLLMUsed(self, newModel):
        print("Swapped Model From ",self.kqlParameters.ollama_model, " To: ", newModel)
        # Update New Parser
        self.kqlParameters.ollama_model = newModel
        self.kql_query_handler = KQLQueryHandler(self.kqlParameters)