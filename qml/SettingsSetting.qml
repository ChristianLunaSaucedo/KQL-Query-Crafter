import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: subSettingRect
    Layout.fillWidth: true
    Layout.fillHeight: true

    Layout.preferredHeight: 1
    Layout.preferredWidth: 1

    property string settingText: "Sub Heading"

    default property alias content: subSettingLayout.data

    color: "transparent"

    RowLayout {
        id: subSettingLayout
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        Text {
            id: subSettingText
            color: "#F6F9FA"
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 1
            font.family: mainWindow.appFont
            font.pointSize: Math.min(parent.implicitHeight * 0.45, settingsText.font.pointSize * 0.35)
            text: subSettingRect.settingText
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            leftPadding: 20
        }

        Item {
            id: invisibleSpacer

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 1
        }
    }
}
