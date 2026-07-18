import sys
from PyQt6.QtGui import QGuiApplication
from PyQt6.QtQml import QQmlApplicationEngine

# Initialize the application
app = QGuiApplication(sys.argv)

# Create the QML application engine
engine = QQmlApplicationEngine()
engine.quit.connect(app.quit)

# Load the QML file
engine.load(".\qml\main.qml")

# Start the event loop
sys.exit(app.exec())
