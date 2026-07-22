pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ApplicationWindow {
    id: mainWindow
    width: 1280
    height: 960
    visible: true
    title: qsTr("KQL Query")
    color: settingsPage.color_5

    FontLoader {
        id: iosevkaFont
    }

    // General Styling Properties
    property double cornerRadius: 15
    property string appFont: iosevkaFont.name

    // Button Properties
    property int buttonEasing: Easing.InOutQuad
    property double buttonOpacity: 0.7
    property double buttonScale: 1.05
    property double buttonDuration: 75

    // Main Paths For App
    property string cancelPath: ""
    property string copyPath: ""
    property string helpPath: ""
    property string resetPath: ""
    property string sendPath: ""
    property string settingPath: ""
    property string trashPath: ""

    Component.onCompleted: {
        console.log("OBTAINING IMAGE PATHS");
        cancelPath = assetsManager.GetAssetPath("cancel.png");
        copyPath = assetsManager.GetAssetPath("copy.png");
        helpPath = assetsManager.GetAssetPath("help.png");
        resetPath = assetsManager.GetAssetPath("reset.png");
        sendPath = assetsManager.GetAssetPath("send.png");
        settingPath = assetsManager.GetAssetPath("setting.png");
        trashPath = assetsManager.GetAssetPath("trash.png");
        iosevkaFont.source = assetsManager.GetFontPath();
    }

    SwipeView {
        id: mainSwipeView
        anchors.fill: parent

        clip: true
        interactive: false

        contentItem.width: width

        currentIndex: 0
        MainPage {
            id: mainPage
        }
        SettingsPage {
            id: settingsPage
        }
    }
}
