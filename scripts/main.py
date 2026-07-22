import sys
import os

from PyQt6.QtGui import QGuiApplication
from PyQt6.QtQml import QQmlApplicationEngine

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
