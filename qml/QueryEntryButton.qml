import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

AnimatedButton {
    id: button

    property int startingRow: 0
    property int startingColumn: 0

    imageScaledFactor: 0.55

    Layout.fillWidth: true
    Layout.fillHeight: false

    Layout.preferredWidth: 1
    Layout.preferredHeight: 100

    Layout.row: startingRow
    Layout.rowSpan: 1
    Layout.column: startingColumn
    Layout.columnSpan: 1
}
