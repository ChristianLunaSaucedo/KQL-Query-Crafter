import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
    color: "#1D222A"

    AnimatedButton {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 75
        imageSource: "..\\assets\\cancel.png"
        buttonColor: "transparent"

        imageScaledFactor: 12

        pressedFunctionality: () => {
            mainSwipeView.currentIndex = 0;
        }
    }

    Text {
        id: settingsText

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 50
        anchors.bottomMargin: 50

        font.pointSize: Math.max(8, parent.height * 0.1)
        height: parent.height * 0.2
        color: "white"
        font.family: mainWindow.appFont
        text: "Settings"
    }

    Rectangle {
        id: settingsContainer
        anchors.top: settingsText.bottom
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.7
        color: "transparent"

        ColumnLayout {
            anchors.fill: parent
            spacing: 5

            Rectangle {
                id: appearanceBehaviorRect
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredHeight: 1
                Layout.preferredWidth: 1

                property string headingText: "<HEADING>"

                color: "transparent"

                Text {
                    id: appearanceBehaviorText
                    anchors.fill: parent
                    color: "#375077"
                    font.pointSize: settingsText.font.pointSize * 0.5
                    font.family: mainWindow.appFont
                    horizontalAlignment: Qt.AlignLeft
                    verticalAlignment: Qt.AlignVCenter
                    text: "Appearance & Behavior"
                    padding: 20
                }
            }

            Rectangle {
                id: themeRect
                Layout.fillWidth: true
                Layout.fillHeight: true

                Layout.preferredHeight: 1
                Layout.preferredWidth: 1

                property string subSettingText: "Sub Heading"

                color: "transparent"

                RowLayout {
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 10

                    Text {
                        id: themeText
                        color: "#F6F9FA"
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.preferredWidth: 1
                        font.family: mainWindow.appFont
                        font.pointSize: appearanceBehaviorText.font.pointSize * 0.75
                        text: "Theme: "
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: 50
                    }

                    // Note: When using component ensure you make this a user passed in component NOT IN THE QML FILE
                    ComboBox {
                        id: themeSelectionBox
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.preferredWidth: 3
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

                        currentIndex: 0

                        background: Rectangle {
                            color: "#F6F9FA"
                            radius: mainWindow.cornerRadius
                            clip: true
                        }

                        contentItem: Text {
                            color: "#375077"
                            text: themeSelectionBox.currentText
                            font.family: mainWindow.appFont
                            font.pointSize: themeText.font.pointSize

                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        model: themeModel
                        ListModel {
                            id: themeModel
                            ListElement {
                                key: "Theme 1"
                            }

                            ListElement {
                                key: "Theme 2"
                            }

                            ListElement {
                                key: "Theme 3"
                            }
                        }
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true

                Layout.preferredHeight: 1
                Layout.preferredWidth: 1

                color: "green"
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true

                Layout.preferredHeight: 1
                Layout.preferredWidth: 1

                color: "blue"
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true

                Layout.preferredHeight: 1
                Layout.preferredWidth: 1

                color: "brown"
            }

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredHeight: 0.2
            }
        }
    }
}
