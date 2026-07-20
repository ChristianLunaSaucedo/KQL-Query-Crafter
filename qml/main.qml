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
    color: "#1D222A"

    FontLoader {
        id: iosevkaFont
        source: "..\\fonts\\Iosevka_Charon_Mono\\Regular.ttf"
    }

    property double cornerRadius: 15
    property string appFont: iosevkaFont.name

    property int buttonEasing: Easing.InOutQuad
    property double buttonOpacity: 0.7
    property double buttonScale: 1.05
    property double buttonDuration: 75

    SwipeView {
        id: mainSwipeView
        anchors.fill: parent
        interactive: false
        currentIndex: 0
        MainPage {}
        SettingsPage {}
    }
}
