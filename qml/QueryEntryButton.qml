import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Button {
    id: button

    property int startingRow: 0
    property int startingColumn: 0

    property string imageSource: ""
    property var pressedFunctionality: () => {
        console.log("PRESSED BUTTON");
    }

    Layout.fillWidth: true
    Layout.fillHeight: false
    Layout.preferredWidth: 1
    Layout.preferredHeight: 100

    Layout.row: startingRow
    Layout.rowSpan: 1
    Layout.column: startingColumn
    Layout.columnSpan: 1

    background: Rectangle {
        color: "#F6F9FA"
        radius: cornerRadius

        Image {
            anchors.centerIn: parent
            source: button.imageSource
            fillMode: Image.PreserveAspectFit
            width: Math.max(8, parent.width * 0.55)
            height: Math.max(8, parent.height * 0.55)
        }
    }

    MouseArea {
        id: buttonMouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onPressed: {
            button.pressedFunctionality();
        }
    }
}
