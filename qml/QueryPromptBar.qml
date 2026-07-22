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
        Layout.preferredWidth: 6
        padding: 10

        property bool canType: busyPopup.visible == false
        property bool canSend: query_prompt.text.trim() !== "" && canType

        renderType: Text.NativeRendering
        font.pointSize: Math.max(8, parent.height * 0.3)
        font.family: mainWindow.appFont
        font.wordSpacing: -5

        color: settingsPage.color_3
        selectionColor: "gray"

        placeholderText: canType ? "Enter Scenario..." : ("Loading Query" + queryingTimer.resultingText)
        placeholderTextColor: '#6e375077'

        readOnly: !canType
        wrapMode: Text.Wrap

        background: Rectangle {
            radius: mainWindow.cornerRadius
            color: settingsPage.color_1
        }

        onAccepted: {
            if (canSend)
                mainPage.queryPrompt();
        }
    }

    AnimatedButton {
        id: query_button

        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.preferredWidth: 1

        enabled: query_prompt.canSend

        buttonColor: enabled ? settingsPage.color_1 : Qt.darker(settingsPage.color_1)
        imageSource: "..\\assets\\send.png"
        imageScaledFactor: 0.55
        toolTipText: "Query Prompt"
        pressedFunctionality: () => {
            if (query_prompt.canSend)
                mainPage.queryPrompt();
        }
    }
}
