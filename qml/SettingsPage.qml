import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
    id: settingsPage

    function onSendExistingModel(model) {
        llmModelDropdownModel.append({
            "key": model
        });
    }

    Component.onCompleted: {
        systemController.send_existing_model.connect(settingsPage.onSendExistingModel);

        // Manually Invoke LLM Fetch List
        systemController.FetchLLMList();
    }
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

        // Settings Page Layout
        ColumnLayout {
            id: settingsPageLayout
            anchors.fill: parent
            spacing: 5

            // Appearance & Behavior (Heading)
            SettingsHeading {
                id: appearanceBehaviorHeading

                headingText: "Appearance & Behavior"
            }

            // Theme Setting
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

            // Auto-Copy Setting
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

            // LLM Options (Heading)
            SettingsHeading {
                id: llmOptionsHeading

                headingText: "LLM Options"
            }

            // LLM Setting
            SettingsSetting {
                id: llmModelSetting
                settingText: "LLM Model: "

                SettingsDropdown {
                    id: llmModelDropdown

                    model: ListModel {
                        id: llmModelDropdownModel
                    }

                    onCurrentTextChanged: {
                        systemController.UpdateLLMUsed(currentText);
                    }
                }
            }

            // Invisible Spacer
            Item {
                id: invisibleSpacer
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredHeight: 3
            }
        }
    }
}
