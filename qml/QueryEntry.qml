import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

GridLayout {
    id: queriesDelegateGrid

    property string scenario: ""
    property string query: ""
    property int index: index

    anchors.fill: parent

    anchors.margins: 15

    Layout.alignment: Qt.AlignVCenter

    columnSpacing: 15
    rowSpacing: 15

    QueryEntryText {
        id: scenarioText
        textToDisplay: queriesDelegateGrid.scenario

        startingRow: 0
        startingColumn: 0
    }

    QueryEntryText {
        id: queryText
        textToDisplay: queriesDelegateGrid.query

        startingRow: 1
        startingColumn: 0
    }

    QueryEntryButton {
        id: copyButton

        imageSource: mainWindow.copyPath
        toolTipText: "Copy Query"

        pressedFunctionality: () => {
            systemController.CopyToClipboard(queriesDelegateGrid.query);
        }

        startingRow: 0
        startingColumn: 1
    }

    QueryEntryButton {
        id: removeButton

        imageSource: mainWindow.trashPath
        toolTipText: "Remove Query"

        pressedFunctionality: () => {
            console.log("Removing Text at Index", queriesDelegateGrid.index);
            queriesDelegateRect.height = queriesDelegateRect.height;
            queriesDelegateGrid.focus = true;
            queriesModel.remove(queriesDelegateGrid.index, 1);
        }

        startingRow: 1
        startingColumn: 1
    }
}
