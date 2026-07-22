from PyQt6.QtCore import QObject, QSettings, pyqtSlot as Slot

class SettingsManager(QObject):
    
    def __init__(self):
        super().__init__()

        self.savedSettings = QSettings("Organization", "App")

    @Slot(str, str, result=str)
    def FetchSetting(self, settingName, defaultVal):
        return self.savedSettings.value(settingName, defaultVal, str)

    @Slot(str, str)
    def SetSetting(self, settingName, newValue):
        print("Set ", settingName, " To: ", newValue)
        self.savedSettings.setValue(settingName, newValue)