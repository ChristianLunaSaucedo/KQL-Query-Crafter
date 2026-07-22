import sys, os, ollama

from ollama import ResponseError
from langchain_ollama.llms import OllamaLLM


from KQLQueryBackend import KQLQueryHandler
from RAGParameters import Parameters

from PyQt6.QtGui import QGuiApplication
from PyQt6.QtQml import QQmlApplicationEngine
from PyQt6.QtCore import QObject, pyqtSlot as Slot, pyqtSignal as Signal, QRunnable, QThreadPool, QSettings
from ollama import ResponseError

from SystemController import SystemController
from SettingsManager import SettingsManager

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)

    systemController = SystemController()
    settingsManager = SettingsManager()

    # Create the QML application engine
    engine = QQmlApplicationEngine()
    engine.quit.connect(app.quit)

    # Connecting Python & QML
    engine.rootContext().setContextProperty("systemController", systemController)
    engine.rootContext().setContextProperty("settingsManager", settingsManager)
    
    # Load the QML file
    os.environ["QT_QUICK_CONTROLS_STYLE"] = "Fusion"

    engine.load(".\\qml\\main.qml")
    
    # Start the event loop
    sys.exit(app.exec())
