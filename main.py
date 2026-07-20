import sys, os, ollama

from KQLQueryBackend import KQLQueryHandler

from PyQt6.QtGui import QGuiApplication
from PyQt6.QtQml import QQmlApplicationEngine
from PyQt6.QtCore import QObject, pyqtSlot as Slot, pyqtSignal as Signal, QRunnable, QThreadPool


class SystemController(QObject):
    # Signals To Send To QML
    query_started = Signal()
    query_finished = Signal(str, str)

    @Slot(str)
    def QueryPrompt(self, textToQuery):
        self.query_started.emit()

        # A Class That Runs On Threads
        class Task(QRunnable):
            def __init__(task_self, textToQuery):
                super().__init__()
                task_self.textToQuery = textToQuery
                    
            def run(task_self):
                print("Querying Prompt: ", task_self.textToQuery)
                kql_query_handler = KQLQueryHandler()
                response = kql_query_handler.AskQuestion(task_self.textToQuery)

                print("GOT A Query FROM THREAD: ", response)
                self.query_finished.emit(task_self.textToQuery, response)

        # Spawn Task On New Thread
        task = Task(textToQuery)
        QThreadPool.globalInstance().start(task)
        print("Spawned KQL Query Thread")

    @Slot(str)
    def CopyToClipboard(self, textToCopy):
        clipboard = QGuiApplication.clipboard()
        clipboard.setText(textToCopy)
        print("Copied Text To Clipboard: ", textToCopy)
        pass
    

if __name__ == "__main__":
    # Initialize the application

    # modelList = ollama.list()
    # for model in modelList['models']:
    #     print(model['model'], sep=", ")

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
