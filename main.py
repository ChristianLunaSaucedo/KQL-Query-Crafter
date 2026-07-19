import sys, os

from KQLQueryBackend import KQLQueryHandler

from PyQt6.QtGui import QGuiApplication
from PyQt6.QtQml import QQmlApplicationEngine
from PyQt6.QtCore import QObject, pyqtSlot as Slot


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

        kql_query_handler = KQLQueryHandler()
        response = kql_query_handler.AskQuestion(textToQuery)
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
