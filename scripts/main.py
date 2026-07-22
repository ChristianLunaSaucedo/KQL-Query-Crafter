import sys
import os

from PyQt6.QtGui import QGuiApplication, QIcon
from PyQt6.QtQml import QQmlApplicationEngine

from SystemController import SystemController
from SettingsManager import SettingsManager

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    app.setWindowIcon(QIcon(os.path.join("assets", "icon.png")))

    # Create Python Classes
    systemController = SystemController()
    settingsManager = SettingsManager()

    # Create the QML application engine
    engine = QQmlApplicationEngine()
    engine.quit.connect(app.quit)

    # Connecting Python & QML
    engine.rootContext().setContextProperty("systemController", systemController)
    engine.rootContext().setContextProperty("settingsManager", settingsManager)

    # Specify Default Styling
    os.environ["QT_QUICK_CONTROLS_STYLE"] = "Fusion"

    # Load the QML file
    engine.load(os.path.join("qml", "main.qml"))

    
    # Start the event loop
    sys.exit(app.exec())
