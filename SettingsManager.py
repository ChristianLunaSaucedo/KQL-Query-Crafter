import sys, os, ollama

from ollama import ResponseError
from langchain_ollama.llms import OllamaLLM


from KQLQueryBackend import KQLQueryHandler
from RAGParameters import Parameters

from PyQt6.QtGui import QGuiApplication
from PyQt6.QtQml import QQmlApplicationEngine
from PyQt6.QtCore import QObject, pyqtSlot as Slot, pyqtSignal as Signal, QRunnable, QThreadPool, QSettings
from ollama import ResponseError

class SettingsManager(QObject):
    
    def __init__(self):
        super().__init__()

        # Settings
        self.savedSettings = QSettings("Organization", "App")
        self.FetchSetting("llm_model", "llama3.2")
        self.FetchSetting("theme", "default")
        self.FetchSetting("auto_copy", "Disabled")
    
    @Slot(str, str, str)
    def UpdateSettings(self, llmModel,theme,autoCopy):
        self.savedSettings.setValue("llm_model", llmModel)
        self.savedSettings.setValue("theme", theme)
        self.savedSettings.setValue("auto_copy", autoCopy)

    @Slot(str, str, result=str)
    def FetchSetting(self, settingName, defaultVal):
        return self.savedSettings.value(settingName, defaultVal, str)

    @Slot(str, str)
    def SetSetting(self, settingName, newValue):
        print("Set ", settingName, " To: ", newValue)
        self.savedSettings.setValue(settingName, newValue)