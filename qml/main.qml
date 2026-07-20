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

    function onQueryStarted() {
        queryPromptBar.clearTextField();
        busyPopup.visible = true;

        console.log("On Query Started Signal Emitted (QML)");
    }

    function onQueryFinished(scenario, query) {
        console.log(query, scenario);
        // Adding New Element
        queriesModel.append({
            "scenario": scenario,
            "query": query
        });
        busyPopup.visible = false;

        console.log("On Query Finished Signal Emitted (QML)");
    }

    Component.onCompleted: {
        systemController.query_started.connect(mainWindow.onQueryStarted);
        systemController.query_finished.connect(mainWindow.onQueryFinished);
    }

    function queryPrompt(params) {
        let textToQuery = queryPromptBar.getText();
        if (textToQuery.trim() === "")
            return;

        console.log("Sending Prompt!");

        systemController.QueryPrompt(textToQuery);
    }

    Timer {
        // Runs only when there is a popup timer to add extra effects
        id: queryingTimer
        interval: 500
        running: busyPopup.visible
        repeat: true

        property int elipseCount: 0
        property string resultingText: ""

        onTriggered: {
            console.log("Triggered Timer", elipseCount);
            elipseCount++;
            if (elipseCount > 3) {
                elipseCount = 0;
            }
            resultingText = ".".repeat(elipseCount);
        }
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

        // Tab Bar Pane
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
                tabPressFunctionality: () => {
                    console.log("Settings");
                }
            }

            AnimatedTabButton {
                id: helpButton
                toolTipText: "Help"
                buttonText: ""
                imageSource: "..\\assets\\help.png"
                tabPressFunctionality: () => {
                    console.log("Help");
                }
            }

            AnimatedTabButton {
                id: resetButton
                toolTipText: "Clear History"
                buttonText: ""
                imageSource: "..\\assets\\reset.png"
                tabPressFunctionality: () => {
                    console.log("Cleared History");
                    queriesModel.clear();
                }
                enabledFunctionality: queriesModel.count > 0
            }
        }

        // Queries Pane
        Rectangle {
            id: queries_pane

            Popup {
                id: busyPopup

                anchors.centerIn: parent
                width: parent.width
                height: parent.height

                modal: false

                closePolicy: Popup.NoAutoClose

                visible: false

                background: Rectangle {
                    radius: 8
                    color: '#95000000'

                    BusyIndicator {
                        anchors.centerIn: parent
                        antialiasing: true
                        implicitWidth: parent.width * 0.2
                        implicitHeight: parent.height * 0.2
                    }
                }
            }

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

        // Input Pane
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
        }
    }
}
