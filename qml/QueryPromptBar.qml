import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    id: layout
    anchors.margins: 15
    anchors.fill: parent
    spacing: 15

    property var clearTextField: () => {
        query_prompt.clear();
    }

    property var getText: () => {
        return query_prompt.text;
    }

    TextField {
        id: query_prompt

        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.preferredWidth: 5
        padding: 10

        property bool canSend: false

        renderType: Text.NativeRendering
        font.pointSize: Math.max(8, parent.height * 0.3)
        font.family: appFont
        font.wordSpacing: -5

        color: "#375077"
        selectionColor: "gray"

        placeholderText: "Enter Scenario..."
        placeholderTextColor: '#6e375077'

        wrapMode: Text.Wrap

        background: Rectangle {
            radius: cornerRadius
            color: "#F6F9FA"
        }

        onAccepted: {
            mainWindow.queryPrompt();
        }

        onTextChanged: {
            canSend = query_prompt.text.trim() !== "";
        }
    }

    AnimatedButton {
        id: query_button

        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.preferredWidth: 1

        enabled: query_prompt.canSend

        buttonColor: enabled ? "#F6F9FA" : Qt.darker("#F6F9FA")
        imageSource: "..\\assets\\send.png"
        imageScaledFactor: 0.55
        toolTipText: "Query Prompt"
        pressedFunctionality: () => mainWindow.queryPrompt()
    }
}
