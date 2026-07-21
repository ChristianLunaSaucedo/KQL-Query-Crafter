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

            SettingsHeading {
                id: appearanceBehaviorHeading

                headingText: "Appearance & Behavior"
            }

            SettingsSetting {
                id: themeSetting
                settingText: "Theme: "

                SettingsDropdown {
                    id: themeSelectionDropdown

                    model: ListModel {
                        ListElement {
                            key: "Default"
                        }

                        ListElement {
                            key: "Dark"
                        }

                        ListElement {
                            key: "Light"
                        }
                    }
                }
            }

            SettingsSetting {
                id: autoCopySetting
                settingText: "Auto-Copy: "

                SettingsDropdown {
                    id: autoCopyDropdown

                    model: ListModel {
                        id: autoCopyDropdownModel
                        ListElement {
                            key: "Disabled"
                        }

                        ListElement {
                            key: "Enabled"
                        }
                    }
                }
            }

            SettingsHeading {
                id: llmOptionsHeading

                headingText: "LLM Options"
            }

            SettingsSetting {
                id: llmModelSetting
                settingText: "LLM Model: "

                SettingsDropdown {
                    id: llmModelDropdown

                    model: ListModel {
                        id: llmModelDropdownModel
                        ListElement {
                            key: "LLM Model #1"
                        }

                        ListElement {
                            key: "LLM Model #2"
                        }
                    }
                }
            }

            Item {
                id: invisibleSpacer
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredHeight: 3
            }
        }
    }
}
