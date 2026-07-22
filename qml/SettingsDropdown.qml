import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ComboBox {
    id: settingsDropdown
    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.preferredWidth: 3
    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

    currentIndex: 0

    background: Rectangle {
        color: "#F6F9FA"
        radius: mainWindow.cornerRadius
        clip: true
    }

    contentItem: Text {
        color: "#375077"
        text: settingsDropdown.currentText
        font.family: mainWindow.appFont
        font.pointSize: Math.max(8, settingsText.font.pointSize * 0.3) //Math.max(settingsDropdown.implicitHeight * 0.45, settingsText.font.pointSize * 0.3)

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    model: settingsDropdownModel
    ListModel {
        id: settingsDropdownModel
        ListElement {
            key: "Option 1"
        }

        ListElement {
            key: "Option 2"
        }

        ListElement {
            key: "Option 3"
        }
    }
}
