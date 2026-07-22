from PyQt6.QtCore import QObject, QSettings, pyqtSlot as Slot

# Class Used To Manage Settings For App
class SettingsManager(QObject):
    
    def __init__(self):
        super().__init__()

        self.savedSettings = QSettings("Organization", "App")

    # Retrieves Saved Setting of A Given Name (w/ Default Value If None Exists)
    @Slot(str, str, result=str)
    def FetchSetting(self, settingName, defaultVal):
        return self.savedSettings.value(settingName, defaultVal, str)

    # Saves Setting of A Given Name with a new value
    @Slot(str, str)
    def SetSetting(self, settingName, newValue):
        print("Set ", settingName, " To: ", newValue)
        self.savedSettings.setValue(settingName, newValue)