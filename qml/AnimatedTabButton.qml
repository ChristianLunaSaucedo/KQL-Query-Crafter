import QtQuick
import QtQuick.Controls

TabButton {
    id: control

    // Explicitly set sizes so the TabBar can distribute layout room evenly
    implicitWidth: 120
    implicitHeight: 40

    // Custom Styling: This styling applies automatically to every button
    contentItem: Text {
        text: control.text
        font.pixelSize: 14
        font.bold: control.checked // Make text bold if this tab is active
        color: control.checked ? "#2196F3" : "#666666" // Blue if active, gray if not
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        color: control.checked ? "#E3F2FD" : (control.hovered ? "#F5F5F5" : "transparent")
        border.color: control.checked ? "#2196F3" : "transparent"
        border.width: 1
    }
}
