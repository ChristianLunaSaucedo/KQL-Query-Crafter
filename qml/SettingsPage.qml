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

    property string savedTheme: ""
    property string savedAutoCopy: ""
    property string savedLLMModel: ""

    property bool autoCopyEnabled: false

    Component.onCompleted: {
        systemController.send_existing_model.connect(settingsPage.onSendExistingModel);

        // Manually Invoke LLM Fetch List
        systemController.FetchLLMList();

        // Get Saved Values
        savedTheme = settingsManager.FetchSetting("theme", "Dark");
        console.log("Loaded Theme: ", savedTheme);

        savedAutoCopy = settingsManager.FetchSetting("auto_copy", "Disabled");
        console.log("Loaded AutoClick: ", savedAutoCopy);

        savedLLMModel = settingsManager.FetchSetting("llm_model", "None");
        console.log("Loaded LLM Model: ", savedLLMModel);

        // Use Saved Values
        llmModelDropdown.currentValue = savedLLMModel;
        themeSelectionDropdown.currentValue = savedTheme;
        autoCopyDropdown.currentValue = savedAutoCopy;
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

            // Appearance & Behavior (Header)
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

                    onActivated: {
                        settingsManager.SetSetting("theme", currentText);
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

                    onCurrentValueChanged: {
                        settingsPage.autoCopyEnabled = currentValue == "Enabled";
                        console.log("CHANGED AUTO COPY TEXT To: ", settingsPage.autoCopyEnabled);
                    }

                    onActivated: {
                        settingsManager.SetSetting("auto_copy", currentText);
                    }
                }
            }

            // LLM Options (Header)
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

                        ListElement {
                            key: "None"
                        }
                    }

                    onCurrentTextChanged: {
                        systemController.UpdateLLMUsed(currentText);
                    }
                    onActivated: {
                        settingsManager.SetSetting("llm_model", currentText);
                    }
                }
            }

            // Invisible Spacer
            Item {
                id: invisibleSpacer
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredHeight: 2
            }
        }
    }
}
