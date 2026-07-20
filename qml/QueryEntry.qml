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
