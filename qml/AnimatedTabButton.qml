import QtQuick
import QtQuick.Controls

TabButton {
    id: button
    property string buttonText: ""
    property string toolTipText: "Tool Tip"
    property string imageSource: ""

    property bool enabledFunctionality: true

    property var tabPressFunctionality: () => {
        console.log("Tab Button Pressed");
    }

    background: Rectangle {
        color: "transparent"
    }

    anchors.top: parent.top
    anchors.bottom: parent.bottom

    AnimatedButton {
        anchors.fill: parent
        toolTipText: button.toolTipText
        imageSource: button.imageSource

        enabled: button.enabledFunctionality

        imageScaledFactor: 0.8
        buttonColor: enabled ? settingsPage.color_3 : Qt.darker(settingsPage.color_3)

        pressedFunctionality: () => {
            button.tabPressFunctionality();
        }
    }
}
