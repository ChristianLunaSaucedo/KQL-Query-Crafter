import os

from PyQt6.QtCore import QObject, pyqtSlot as Slot

# Class Used To Easily Manage Assets (i.e. Images)
class AssetsManager(QObject):
    def __init__(self):
        super().__init__()
        self.assetPath = "assets"

    # Gets the path for an asset in the assets folder
    @Slot(str, result=str)
    def GetAssetPath(self, assetName):
        return os.path.join("..", self.assetPath, assetName) 

    # Gets the path for the main font (Can be optimized for multiple fonts)
    @Slot(result=str)
    def GetFontPath(self):
        return os.path.join("..", "fonts", "Iosevka_Charon_Mono", "Regular.ttf") 
