import QtQuick
import QtQuick.Layouts

Window {
    id: mainWindow
    width: 1280
    height: 960
    visible: true
    title: qsTr("KQL Query")
    color: "#1D222A"

    property double cornerRadius: 20

    GridLayout {
        anchors.fill: parent
        columnSpacing: 50
        rowSpacing: 50
        anchors.leftMargin: 50
        anchors.rightMargin: 50
        anchors.topMargin: 50
        anchors.bottomMargin: 50

        rows: 2
        columns: 2

        Rectangle {
            id: left_pane
            color: "#375077"
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.row: 0
            Layout.rowSpan: 2
            Layout.column: 0
            Layout.columnSpan: 1
            Layout.preferredWidth: 1
            radius: cornerRadius
        }

        Rectangle {
            id: queries_pane
            color: "#F6F9FA"

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.row: 0
            Layout.column: 1
            Layout.rowSpan: 1
            Layout.columnSpan: 1
            Layout.preferredWidth: 3
            Layout.preferredHeight: 8

            radius: cornerRadius
        }

        Rectangle {
            id: input_pane
            color: "#375077"
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.row: 1
            Layout.rowSpan: 1
            Layout.column: 1
            Layout.columnSpan: 1
            Layout.preferredWidth: 2
            Layout.preferredHeight: 1

            radius: cornerRadius

            FontLoader {
                id: iosekva_font
                source: "fonts\\Iosevka_Charon_Mono\\IosevkaCharonMono-Light.ttf"
            }

            // Rectangle {
            //     id: prompt_text
            //     anchors.left: parent.left
            //     anchors.top: parent.top
            //     anchors.bottom: parent.bottom
            //     width: parent.width * 0.15
            //     Text {
            //         anchors.fill: parent
            //         font.pointSize: 32
            //         horizontalAlignment: Text.AlignLeft
            //         verticalAlignment: Text.AlignVCenter
            //         text: "Prompt: "
            //         font.family: iosekva_font.name
            //         fontSizeMode: Text.Fit
            //         minimumPointSize: 2
            //     }
            // }

            Text {
                id: prompt_text
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                font.pointSize: 32
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "Prompt: "
                font.family: iosekva_font.name
                fontSizeMode: Text.Fit
                minimumPointSize: 2
                width: parent.width * 0.15
            }

            Rectangle {
                id: input_area

                anchors.left: prompt_text.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: (parent.width - prompt_text.width)
                color: "red"
            }
        }
    }
}
