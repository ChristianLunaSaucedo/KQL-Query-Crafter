import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
    color: "#1D222A"

    Image {}

    AnimatedButton {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 50
        imageSource: "..\\assets\\cancel.png"
        buttonColor: "transparent"

        scale: 10

        pressedFunctionality: () => {
            mainSwipeView.currentIndex = 0;
        }
    }

    GridLayout {
        anchors.fill: parent

        rowSpacing: 20
        columnSpacing: 20

        rows: 2
        columns: 1

        Rectangle {
            Layout.preferredWidth: 100
            Layout.preferredHeight: 100
            color: "white"
            Layout.row: 0
            Layout.column: 0
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        Rectangle {
            Layout.preferredWidth: 100
            Layout.preferredHeight: 100
            color: "red"

            Layout.row: 1
            Layout.column: 0
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
