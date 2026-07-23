import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs

Item {
    id: mainPage

    property bool isQuerying: busyPopup.visible === true
    function onQueryStarted() {
        queryPromptBar.clearTextField();
        busyPopup.visible = true;

        console.log("On Query Started Signal Emitted (QML)");
    }

    function onQueryFinished(scenario, query, isInformationOnly) {
        console.log("On Query Finished Signal Emitted (QML)");
        busyPopup.visible = false;
        console.log(scenario, query);

        onSendResponse(scenario, query, isInformationOnly);

        // Auto Send Query To Clipboard when querying
        if (settingsPage.autoCopyEnabled && !isInformationOnly) {
            systemController.CopyToClipboard(query);
            console.log("Auto Copied: ", query);
        }
    }

    function onSendResponse(scenario, query, isInformationOnly) {
        // In case of an invalid query
        if (query === "Error") {
            // Adding New Element
            queriesModel.append({
                "scenario": "Error Generating A Query",
                "query": "Please Select A Valid Generation/Embedding Model From Settings Menu"
            });
            return;
        }

        // Adding New Element
        queriesModel.append({
            "scenario": scenario,
            "query": query
        });
    }

    function queryPrompt(params) {
        let textToQuery = queryPromptBar.getText();
        if (textToQuery.trim() === "")
            return;

        console.log("Sending Prompt!");

        systemController.QueryPrompt(textToQuery);
    }

    // Start Function
    Component.onCompleted: {
        systemController.query_started.connect(mainPage.onQueryStarted);
        systemController.query_finished.connect(mainPage.onQueryFinished);
        systemController.send_response.connect(mainPage.onSendResponse);
    }

    // Effects Timer
    Timer {
        // Runs only when there is a popup timer to add extra effects
        id: queryingTimer
        interval: 500
        running: busyPopup.visible
        repeat: true

        property int elipseCount: 0
        property string resultingText: ""

        onTriggered: {
            elipseCount++;
            if (elipseCount > 3) {
                elipseCount = 0;
            }
            resultingText = ".".repeat(elipseCount);
        }
    }

    // [ Window Content Starts Here ]
    GridLayout {
        id: mainPageLayout
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
                imageSource: mainWindow.settingPath
                tabPressFunctionality: () => {
                    console.log("Settings");
                    mainSwipeView.currentIndex = 1;
                }
            }

            AnimatedTabButton {
                id: helpButton
                toolTipText: "Help"
                buttonText: ""
                imageSource: mainWindow.helpPath
                tabPressFunctionality: () => {
                    console.log("Help");
                    helpDialog.open();
                }
            }

            MessageDialog {
                id: helpDialog
                title: "Open KQL Query Page"
                text: "Would you like to open the Official KQL Query Reference Page?"

                buttons: MessageDialog.Yes | MessageDialog.No

                onAccepted: {
                    console.log("Confirm Help");
                    Qt.openUrlExternally("https://www.elastic.co/docs/reference/query-languages/kql");
                }

                onRejected: {
                    console.log("Rejected  Help");
                }
            }

            AnimatedTabButton {
                id: resetButton
                toolTipText: "Clear History"
                buttonText: ""
                imageSource: mainWindow.resetPath
                tabPressFunctionality: () => {
                    clearHistoryDialog.open();
                }
                enabledFunctionality: queriesModel.count > 0
            }

            MessageDialog {
                id: clearHistoryDialog
                title: "Clear History"
                text: "You have existing query entries. Would you like to clear your history?"

                buttons: MessageDialog.Yes | MessageDialog.No

                onAccepted: {
                    console.log("Cleared History");
                    queriesModel.clear();
                }
                onRejected: {
                    console.log("Cancelled Clear History.");
                }
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

            color: settingsPage.color_1

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.row: 1
            Layout.rowSpan: 1

            Layout.column: 0
            Layout.columnSpan: 2

            Layout.preferredWidth: 3
            Layout.preferredHeight: 8

            radius: mainWindow.cornerRadius

            ListModel {
                id: queriesModel

                // ListElement {
                //     scenario: "test"
                //     query: "test"
                // }
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

                    color: settingsPage.color_2
                    radius: mainWindow.cornerRadius

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
            color: settingsPage.color_3
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.row: 2
            Layout.rowSpan: 1
            Layout.column: 0
            Layout.columnSpan: 2
            Layout.preferredWidth: 2
            Layout.preferredHeight: 1

            radius: mainWindow.cornerRadius

            QueryPromptBar {
                id: queryPromptBar
            }
        }
    }
}
