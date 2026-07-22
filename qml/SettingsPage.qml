import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
    id: settingsPage

    function onSendExistingModel(model) {
        llmModelDropdownModel.append({
            "key": model
        });

        embeddingModelDropdownModel.append({
            "key": model
        });
    }

    function setCorrectTheme(themeName) {
        if (themeName == "Dark") {
            color_1 = "#FBFBFB";
            color_2 = "#BCABAE";
            color_3 = "#716969";
            color_4 = "#2D2E2E";
            color_5 = "#0F0F0F";
        } else if (themeName == "Blue") {
            color_1 = "#6DAEDB";
            color_2 = "#173753";
            color_3 = "#2892D7";
            color_4 = "#1B4353";
            color_5 = "#1D70A2";
        } else if (themeName == "Pink Gold") {
            color_1 = "#DAD6D6";
            color_2 = "#92BFB1";
            color_3 = "#F4AC45";
            color_4 = "#694A38";
            color_5 = "#A61C3C";
        } else if (themeName == "Blue Brown") {
            color_1 = "#FFECD1";
            color_2 = "#FF7D00";
            color_3 = "#78290F";
            color_4 = "#15616D";
            color_5 = "#001524";
        } else {
            color_1 = "#f6f9fa";
            color_2 = "#8cbdc7";
            color_3 = "#375077";
            color_4 = "#4e8ec8";
            color_5 = "#1d222a";
        }

        console.log("Set Custom Theme To: ", themeName);
    }

    property string color_1: "#f6f9fa"
    property string color_2: "#8cbdc7"
    property string color_3: "#375077"
    property string color_4: "#4e8ec8"
    property string color_5: "#1d222a"

    property string savedTheme: ""
    property string savedAutoCopy: ""
    property string savedLLMModel: ""
    property string savedEmbeddingModel: ""

    property bool autoCopyEnabled: false

    Component.onCompleted: {
        systemController.send_existing_model.connect(settingsPage.onSendExistingModel);

        // Manually Invoke LLM Fetch List
        systemController.FetchLLMList();

        // Get Saved Values
        savedTheme = settingsManager.FetchSetting("theme", "Default");
        console.log("Loaded Theme: ", savedTheme);

        savedAutoCopy = settingsManager.FetchSetting("auto_copy", "Disabled");
        console.log("Loaded AutoClick: ", savedAutoCopy);

        savedLLMModel = settingsManager.FetchSetting("llm_model", "None");
        console.log("Loaded LLM Model: ", savedLLMModel);

        savedEmbeddingModel = settingsManager.FetchSetting("embedding_model", "None");
        console.log("Loaded Embedding Model: ", savedLLMModel);

        // Use Saved Values
        llmModelDropdown.currentValue = savedLLMModel;
        embeddingModelDropdown.currentValue = savedEmbeddingModel;
        themeSelectionDropdown.currentValue = savedTheme;
        autoCopyDropdown.currentValue = savedAutoCopy;

        setCorrectTheme(savedTheme);
    }
    color: settingsPage.color_5

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

                ToolTip.visible: themeSelectionDropdown.hovered
                ToolTip.text: "Theme"

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
                            key: "Blue"
                        }

                        ListElement {
                            key: "Pink Gold"
                        }

                        ListElement {
                            key: "Blue Brown"
                        }
                    }

                    onActivated: {
                        settingsManager.SetSetting("theme", currentText);
                        settingsPage.setCorrectTheme(currentText);
                    }
                }
            }

            // Auto-Copy Setting
            SettingsSetting {
                id: autoCopySetting
                settingText: "Auto-Copy: "

                ToolTip.visible: autoCopyDropdown.hovered
                ToolTip.text: "Auto Copy Query"

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

            // Generation Model Setting
            SettingsSetting {
                id: llmModelSetting
                settingText: "Generation Model: "

                ToolTip.visible: llmModelDropdown.hovered
                ToolTip.text: "Generation Model Used"

                SettingsDropdown {
                    id: llmModelDropdown

                    model: ListModel {
                        id: llmModelDropdownModel

                        ListElement {
                            key: "None"
                        }
                    }

                    onCurrentTextChanged: {
                        systemController.UpdateGenerationLLM(currentText);
                    }
                    onActivated: {
                        settingsManager.SetSetting("llm_model", currentText);
                    }
                }
            }

            // Embedding Model Setting
            SettingsSetting {
                id: embeddingModelSetting
                settingText: "Embedding Model: "

                ToolTip.visible: embeddingModelDropdown.hovered
                ToolTip.text: "Embedding Model Used"

                SettingsDropdown {
                    id: embeddingModelDropdown

                    model: ListModel {
                        id: embeddingModelDropdownModel

                        ListElement {
                            key: "None"
                        }
                    }

                    onCurrentTextChanged: {
                        systemController.UpdateEmbeddingModel(currentText);
                    }
                    onActivated: {
                        settingsManager.SetSetting("embedding_model", currentText);
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
