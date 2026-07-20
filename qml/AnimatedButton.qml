import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Button {
    id: button

    property string toolTipText: "TT"
    property string imageSource: ""

    property double imageScaledFactor: 1
    property string buttonColor: "#F6F9FA"

    property var pressedFunctionality: () => {
        console.log("Button Pressed!");
    }

    scale: button.hovered ? buttonScale : 1
    opacity: button.hovered ? buttonOpacity : 1

    ToolTip.visible: button.hovered
    ToolTip.text: toolTipText

    Behavior on scale {
        NumberAnimation {
            duration: buttonDuration
            easing.type: buttonEasing
        }
    }

    background: Rectangle {
        radius: cornerRadius

        color: buttonMouseArea.pressed ? Qt.darker(button.buttonColor) : button.buttonColor

        Behavior on color {
            ColorAnimation {
                duration: buttonDuration
                easing.type: buttonEasing
            }
        }

        Image {
            anchors.centerIn: parent
            source: button.imageSource
            fillMode: Image.PreserveAspectFit
            width: Math.max(8, parent.width * button.imageScaledFactor)
            height: Math.max(8, parent.height * button.imageScaledFactor)
        }
    }

    MouseArea {
        id: buttonMouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onPressed: {
            button.pressedFunctionality();
        }
    }
}
