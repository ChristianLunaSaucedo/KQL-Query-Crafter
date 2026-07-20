import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

TextField {
    id: scenarioText

    property string textToDisplay: ""

    property int startingRow: 0
    property int startingColumn: 0

    Layout.fillWidth: true
    // Layout.fillHeight: false

    Layout.row: startingRow
    Layout.rowSpan: 1

    Layout.column: startingColumn
    Layout.columnSpan: 1

    Layout.preferredWidth: 8
    Layout.preferredHeight: 100

    padding: 30

    color: "#1D222A"

    background: Rectangle {
        color: "#F6F9FA"
        radius: mainWindow.cornerRadius
    }

    text: textToDisplay
    font.family: mainWindow.appFont

    selectionColor: "gray"

    readOnly: true

    font.pointSize: Math.max(8, Layout.preferredHeight * 0.25)
    horizontalAlignment: Text.AlignLeft
}
