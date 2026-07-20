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
