import QtQuick
import QtQuick.Controls

TabButton {
    id: button
    property string buttonText: ""
    property string toolTipText: "Tool Tip"
    property string imageSource: "..\\assets\\reset.png"

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
        buttonColor: enabled ? "#375077" : Qt.darker("#375077")

        pressedFunctionality: () => {
            button.tabPressFunctionality();
        }
    }
}
