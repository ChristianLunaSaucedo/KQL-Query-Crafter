import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: settingsHeading

    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.preferredHeight: 1
    Layout.preferredWidth: 1

    property string headingText: "<HEADING>"

    color: "transparent"

    Text {
        id: settingsHeadingText
        anchors.fill: parent
        color: "#375077"
        font.pointSize: settingsText.font.pointSize * 0.4
        font.family: mainWindow.appFont
        horizontalAlignment: Qt.AlignLeft
        verticalAlignment: Qt.AlignVCenter
        text: settingsHeading.headingText
        padding: 20
    }
}
