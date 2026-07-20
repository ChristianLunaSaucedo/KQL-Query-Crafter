pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ApplicationWindow {
    id: mainWindow
    width: 1280
    height: 960
    visible: true
    title: qsTr("KQL Query")
    color: "#1D222A"

    property double cornerRadius: 25
    property string appFont: "Consolas"

    property int buttonEasing: Easing.InOutQuad
    property double buttonOpacity: 0.7
    property double buttonScale: 1.05
    property double buttonDuration: 75

    function queryPrompt(params) {
        let textToQuery = queryPromptBar.getText();
        if (textToQuery.trim() === "")
            return;

        console.log("Sending Prompt!");
        queryPromptBar.clearTextField();
        let resultingQuery = systemController.QueryPrompt(textToQuery);
        console.log(resultingQuery);
        // Adding New Element
        queriesModel.append({
            "scenario": textToQuery,
            "query": resultingQuery
        });
    }

    GridLayout {
        anchors.fill: parent
        columnSpacing: 50
        rowSpacing: 50
        anchors.leftMargin: 50
        anchors.rightMargin: 50
        anchors.topMargin: 50
        anchors.bottomMargin: 50

        rows: 3
        columns: 2
        TabBar {
            id: mainTabBar

            spacing: 30

            Layout.fillWidth: true
            Layout.fillHeight: true

            Layout.row: 0
            Layout.rowSpan: 1
            Layout.column: 0
            Layout.columnSpan: 1
            Layout.preferredHeight: 0.75

            background: Rectangle {
                color: "transparent"
            }

            AnimatedTabButton {
                id: settingButton
                toolTipText: "Settings"
                buttonText: ""
                imageSource: "..\\assets\\setting.png"
            }

            AnimatedTabButton {
                id: helpButton
                toolTipText: "Help"
                buttonText: ""
                imageSource: "..\\assets\\help.png"
            }

            AnimatedTabButton {
                id: resetButton
                toolTipText: "Clear History"
                buttonText: ""
                imageSource: "..\\assets\\reset.png"
            }
        }

        Rectangle {
            id: queries_pane
            color: "#F6F9FA"

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.row: 1
            Layout.rowSpan: 1

            Layout.column: 0
            Layout.columnSpan: 2

            Layout.preferredWidth: 3
            Layout.preferredHeight: 8

            radius: cornerRadius

            ListModel {
                id: queriesModel

                ListElement {
                    scenario: "test"
                    query: "test"
                }
            }

            ListView {
                id: queries_view

                reuseItems: false
                clip: true

                anchors.fill: parent
                anchors.margins: 50

                spacing: 50

                model: queriesModel
                delegate: Rectangle {
                    id: queriesDelegateRect
                    z: 2

                    width: queries_view.width
                    height: queryEntry.implicitHeight + 28

                    required property string scenario
                    required property string query
                    required property int index

                    color: "#8CBDC7"
                    radius: cornerRadius

                    QueryEntry {
                        id: queryEntry
                        scenario: queriesDelegateRect.scenario
                        query: queriesDelegateRect.query
                        index: queriesDelegateRect.index
                    }
                }
            }
        }

        Rectangle {
            id: input_pane
            color: "#375077"
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.row: 2
            Layout.rowSpan: 1
            Layout.column: 0
            Layout.columnSpan: 2
            Layout.preferredWidth: 2
            Layout.preferredHeight: 1

            radius: cornerRadius

            QueryPromptBar {
                id: queryPromptBar
            }
            // RowLayout {
            //     anchors.margins: 15
            //     anchors.fill: parent
            //     spacing: 15
            //     TextField {
            //         id: input_prompt_field

            //         Layout.fillHeight: true
            //         Layout.fillWidth: true
            //         Layout.preferredWidth: 5
            //         padding: 10

            //         renderType: Text.NativeRendering
            //         font.pointSize: Math.max(8, height * 0.3)
            //         font.family: appFont
            //         font.wordSpacing: -5

            //         color: "#375077"
            //         selectionColor: "gray"

            //         placeholderText: "Enter Scenario..."
            //         placeholderTextColor: '#6e375077'

            //         wrapMode: Text.Wrap

            //         background: Rectangle {
            //             radius: cornerRadius
            //             color: "#F6F9FA"
            //         }
            //         onAccepted: {
            //             mainWindow.queryPrompt();
            //         }
            //     }

            //     AnimatedButton {
            //         id: query_button

            //         Layout.fillHeight: true
            //         Layout.fillWidth: true
            //         Layout.preferredWidth: 1

            //         buttonColor: "#F6F9FA"
            //         imageSource: "..\\assets\\send.png"
            //         imageScaledFactor: 0.55
            //         toolTipText: "Query Prompt"
            //         pressedFunctionality: () => mainWindow.queryPrompt()
            //     }
            // }

            // Text {
            //     id: prompt_text
            //     anchors.left: parent.left
            //     anchors.top: parent.top
            //     anchors.bottom: parent.bottom
            //     font.pointSize: Math.max(8, height * 0.3)
            //     horizontalAlignment: Text.AlignHCenter
            //     verticalAlignment: Text.AlignVCenter
            //     text: "Prompt: "
            //     font.family: appFont
            //     fontSizeMode: Text.Fit
            //     renderType: Text.HighRenderTypeQuality
            //     width: parent.width * 0.15
            // }

            // TextField {

            //     anchors.left: prompt_text.right
            //     anchors.verticalCenter: parent.verticalCenter
            //     anchors.rightMargin: 30
            //     height: Math.max(8, parent.height * 0.75)
            //     width: parent.width * 0.75

            //     id: input_prompt_field
            //     font.pointSize: Math.max(8, height * 0.3)
            //     font.family: appFont
            //     font.wordSpacing: -5
            //     renderType: Text.NativeRendering
            //     color: "#375077"
            //     selectionColor: "gray"
            //     placeholderText: "Enter Scenario..."
            //     placeholderTextColor: '#6e375077'
            //     wrapMode: Text.Wrap
            //     background: Rectangle {
            //         radius: cornerRadius
            //         color: "#F6F9FA"
            //     }
            //     onAccepted: {
            //         queryPrompt();
            //     }
            // }

            // Item {
            //     id: send_button
            //     width: parent.width * 0.1
            //     anchors.leftMargin: 10

            //     anchors.left: input_prompt_field.right
            //     anchors.right: parent.right
            //     anchors.bottom: parent.bottom
            //     anchors.top: parent.top

            //     Image {
            //         id: send_image
            //         anchors.centerIn: parent
            //         source: "..\\assets\\send.png"
            //         width: parent.width * 0.5
            //         height: Math.max(8, parent.height * 0.5)
            //         fillMode: Image.PreserveAspectFit
            //         opacity: mouse_area.containsPress ? 0.3 : 1

            //         Behavior on opacity {
            //             NumberAnimation {
            //                 duration: 100
            //             }
            //         }

            //         MouseArea {
            //             id: mouse_area
            //             anchors.fill: parent
            //             cursorShape: Qt.PointingHandCursor

            //             onClicked: {
            //                 queryPrompt();
            //             }
            //         }
            //     }
            // }
        }
    }
}
