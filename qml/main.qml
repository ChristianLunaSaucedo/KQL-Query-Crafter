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

    property double cornerRadius: 25
    property string appFont: "Consolas"

    property int buttonEasing: Easing.InOutQuad
    property double buttonOpacity: 0.7
    property double buttonScale: 1.05
    property double buttonDuration: 75

    SwipeView {
        anchors.fill: parent
        currentIndex: 0
        MainPage {}
        SettingsPage {}
    }
}
