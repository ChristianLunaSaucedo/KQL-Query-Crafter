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
        let textToQuery = input_prompt_field.text;
        if (textToQuery.trim() === "")
            return;

        console.log("Sending Prompt!");
        input_prompt_field.clear();
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

            TabButton {
                id: firstButton
                background: Rectangle {
                    radius: cornerRadius
                    color: "#375077"
                    scale: firstButton.hovered ? buttonScale : 1
                    opacity: firstButton.hovered ? buttonOpacity : 1

                    Behavior on scale {
                        NumberAnimation {
                            duration: buttonDuration
                            easing.type: buttonEasing
                        }
                    }
                }
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                HoverHandler {
                    id: firstButtonArea
                    cursorShape: Qt.PointingHandCursor
                }

                text: "BUTTON 1"
                ToolTip.text: "CLEAR"
                ToolTip.visible: firstButtonArea.hovered

                Image {
                    anchors.centerIn: parent
                    source: "..\\assets\\reset.png"
                    fillMode: Image.PreserveAspectFit
                    height: parent.height * 0.8
                    width: parent.width * 0.8
                }
            }

            TabButton {
                id: secondButton
                background: Rectangle {
                    radius: cornerRadius
                    color: "red"
                    scale: secondButton.hovered ? buttonScale : 1
                    opacity: secondButton.hovered ? buttonOpacity : 1

                    Behavior on scale {
                        NumberAnimation {
                            duration: buttonDuration
                            easing.type: buttonEasing
                        }
                    }
                }
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                HoverHandler {
                    id: secondButtonArea
                    cursorShape: Qt.PointingHandCursor
                }

                text: "BUTTON 2"
                ToolTip.text: "DO STUFF"
                ToolTip.visible: secondButtonArea.hovered
            }
        }

        Rectangle {
            id: queries_pane
            color: "#F6F9FA"

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.row: 1
            Layout.column: 0
            Layout.rowSpan: 1
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

                ListElement {
                    scenario: "test"
                    query: "test"
                }

                ListElement {
                    scenario: "test"
                    query: "test"
                }

                ListElement {
                    scenario: "test"
                    query: "test"
                }

                ListElement {
                    scenario: "test"
                    query: "test"
                }

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

                    width: queries_view.width
                    // height: Math.max(8, parent.height * 0.3)
                    height: queriesDelegateGrid.implicitHeight + 28

                    z: 2

                    required property string scenario
                    required property string query
                    required property int index

                    color: "#8CBDC7"
                    radius: cornerRadius

                    GridLayout {
                        id: queriesDelegateGrid
                        anchors.fill: parent

                        anchors.margins: 15

                        Layout.alignment: Qt.AlignVCenter

                        columnSpacing: 15
                        rowSpacing: 15

                        TextField {
                            id: scenarioText
                            Layout.fillWidth: true
                            // Layout.fillHeight: false

                            Layout.preferredWidth: 8
                            Layout.preferredHeight: 100

                            Layout.row: 0
                            Layout.rowSpan: 1
                            Layout.column: 0
                            Layout.columnSpan: 1
                            padding: 30

                            color: "#1D222A"

                            background: Rectangle {
                                color: "#F6F9FA"
                                radius: cornerRadius
                            }

                            text: scenario
                            font.family: appFont

                            selectionColor: "gray"

                            readOnly: true

                            font.pointSize: Math.max(8, Layout.preferredHeight * 0.25)
                            horizontalAlignment: Text.AlignLeft
                        }

                        TextField {
                            id: queryText

                            Layout.fillWidth: true
                            Layout.fillHeight: false
                            Layout.preferredWidth: 8
                            Layout.preferredHeight: 100

                            Layout.row: 1
                            Layout.rowSpan: 1
                            Layout.column: 0
                            Layout.columnSpan: 1
                            padding: 30

                            color: "#1D222A"

                            background: Rectangle {
                                color: "#F6F9FA"
                                radius: cornerRadius
                            }

                            text: query

                            font.family: appFont
                            selectionColor: "gray"

                            readOnly: true

                            font.pointSize: Math.max(8, Layout.preferredHeight * 0.25)
                            horizontalAlignment: Text.AlignLeft
                        }

                        Button {
                            id: copyButton
                            Layout.fillWidth: true
                            Layout.fillHeight: false
                            Layout.preferredWidth: 1
                            Layout.preferredHeight: 100

                            Layout.row: 0
                            Layout.rowSpan: 1
                            Layout.column: 1
                            Layout.columnSpan: 1

                            background: Rectangle {
                                color: "#F6F9FA"
                                radius: cornerRadius

                                Image {
                                    anchors.centerIn: parent
                                    source: "..\\assets\\copy.png"
                                    fillMode: Image.PreserveAspectFit
                                    width: parent.width * 0.55
                                    height: Math.max(8, parent.height * 0.55)
                                }
                            }

                            MouseArea {
                                id: copyButtonMouse
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onPressed: {
                                    systemController.CopyToClipboard(queryText.text);
                                }
                            }
                        }

                        Button {
                            id: removeButton
                            Layout.fillWidth: true
                            Layout.fillHeight: false
                            Layout.preferredWidth: 1
                            Layout.preferredHeight: 100

                            Layout.row: 1
                            Layout.rowSpan: 1
                            Layout.column: 1
                            Layout.columnSpan: 1

                            background: Rectangle {
                                color: "#F6F9FA"
                                radius: cornerRadius

                                Image {
                                    anchors.centerIn: parent
                                    source: "..\\assets\\trash.png"
                                    fillMode: Image.PreserveAspectFit
                                    width: parent.width * 0.55
                                    height: Math.max(8, parent.height * 0.55)
                                }
                            }

                            MouseArea {
                                id: removeButtonMouse
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onPressed: {
                                    console.log("Removing Text at Index", index);
                                    queriesDelegateRect.height = queriesDelegateRect.height;
                                    queriesDelegateGrid.focus = true;
                                    queriesModel.remove(index, 1);
                                }
                            }
                        }
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

            Text {
                id: prompt_text
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                font.pointSize: Math.max(8, height * 0.3)
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "Prompt: "
                font.family: appFont
                fontSizeMode: Text.Fit
                renderType: Text.HighRenderTypeQuality
                width: parent.width * 0.15
            }

            TextField {
                id: input_prompt_field

                anchors.left: prompt_text.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 30
                height: Math.max(8, parent.height * 0.75)
                width: parent.width * 0.75
                font.pointSize: Math.max(8, height * 0.3)
                font.family: appFont
                font.wordSpacing: -5

                renderType: Text.NativeRendering
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
                    queryPrompt();
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
                    height: Math.max(8, parent.height * 0.5)
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

                        onClicked: {
                            queryPrompt();
                        }
                    }
                }
            }
        }
    }
}
