import QtQuick
import QtQuick.Controls

// TabButton {
//     id: button
//     property string buttonText: ""
//     property string toolTipText: "Tool Tip"
//     property string imageSource: "..\\assets\\reset.png"

//     background: Rectangle {
//         radius: cornerRadius
//         color: "#375077"
//         scale: button.hovered ? buttonScale : 1
//         opacity: button.hovered ? buttonOpacity : 1

//         Behavior on scale {
//             NumberAnimation {
//                 duration: buttonDuration
//                 easing.type: buttonEasing
//             }
//         }
//     }
//     anchors.top: parent.top
//     anchors.bottom: parent.bottom

//     HoverHandler {
//         id: buttonArea
//         cursorShape: Qt.PointingHandCursor
//     }

//     text: buttonText
//     ToolTip.text: toolTipText
//     ToolTip.visible: buttonArea.hovered

//     Image {
//         anchors.centerIn: parent
//         source: imageSource
//         fillMode: Image.PreserveAspectFit
//         height: parent.height * 0.8
//         width: parent.width * 0.8

//         scale: button.hovered ? buttonScale : 1

//         Behavior on scale {
//             NumberAnimation {
//                 duration: buttonDuration
//             }
//         }
//     }
// }

TabButton {
    id: button
    property string buttonText: ""
    property string toolTipText: "Tool Tip"
    property string imageSource: "..\\assets\\reset.png"

    background: Rectangle {
        color: "transparent"
    }

    anchors.top: parent.top
    anchors.bottom: parent.bottom

    AnimatedButton {
        anchors.fill: parent
        toolTipText: button.toolTipText
        imageSource: button.imageSource

        imageScaledFactor: 0.8
        buttonColor: "#375077"

        property var pressedFunctionality: () => {
            console.log("Tab Pressed!");
        }
    }
}
