import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

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
            //         font.family: "Consolas"
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
                font.family: "Consolas"
                fontSizeMode: Text.Fit
                renderType: Text.HighRenderTypeQuality
                minimumPointSize: 2
                width: parent.width * 0.15
            }

            TextField {
                id: input_prompt_field

                anchors.left: prompt_text.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 30
                height: parent.height * 0.75
                width: parent.width * 0.75
                font.pointSize: height * 0.3
                font.family: "Consolas"
                font.wordSpacing: -0.01
                renderType: Text.NativeRendering
                color: "#375077"

                placeholderText: "Enter Scenario..."
                placeholderTextColor: '#6e375077'

                wrapMode: Text.Wrap

                background: Rectangle {
                    radius: cornerRadius
                    color: "#F6F9FA"
                }

                onAccepted: {
                    console.log("Sending Prompt!");
                    input_prompt_field.clear();
                }
            }

            Item {
                id: send_button
                width: parent.width * 0.1
                anchors.leftMargin: 10

                anchors.left: input_prompt_field.right
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.top: parent.top

                Image {
                    id: send_image
                    anchors.centerIn: parent
                    source: "..\\assets\\send.png"
                    width: parent.width * 0.5
                    height: parent.height * 0.5
                    fillMode: Image.PreserveAspectFit
                    opacity: mouse_area.containsPress ? 0.3 : 1

                    Behavior on opacity {
                        NumberAnimation {
                            duration: 100
                        }
                    }

                    MouseArea {
                        id: mouse_area
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }
        }
    }
}
