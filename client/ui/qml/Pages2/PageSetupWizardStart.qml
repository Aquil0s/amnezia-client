import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import PageEnum 1.0

import "./"
import "../Controls2"
import "../Config"
import "../Controls2/TextTypes"
import "../Components"

PageType {
    id: root

    Connections {
        target: PageController

        function onGoToPageViewConfig() {
            PageController.goToPage(PageEnum.PageSetupWizardViewConfig)
        }

        function onShowBusyIndicator(visible) {
            busyIndicator.visible = visible
        }
    }

    Connections {
        target: SettingsController

        function onRestoreBackupFinished() {
            PageController.showNotificationMessage(qsTr("Settings restored from backup file"))
            PageController.replaceStartPage()
        }
    }

    FlickableType {
        id: fl
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        contentHeight: content.height

        ColumnLayout {
            id: content

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 0

            Image {
                id: image
                source: "qrc:/images/amneziaBigLogo.png"

                Layout.alignment: Qt.AlignCenter
                Layout.topMargin: 32
                Layout.leftMargin: 8
                Layout.rightMargin: 8
                Layout.preferredWidth: 344
                Layout.preferredHeight: 279
            }

            ParagraphTextType {
                Layout.fillWidth: true
                Layout.topMargin: 50
                Layout.leftMargin: 16
                Layout.rightMargin: 16

                text: qsTr("Free service for creating a personal VPN on your server.") +
                      qsTr(" Helps you access blocked content without revealing your privacy, even to VPN providers.")
            }

            BasicButtonType {
                Layout.fillWidth: true
                Layout.topMargin: 32
                Layout.leftMargin: 16
                Layout.rightMargin: 16

                text: qsTr("I have the data to connect")

                onClicked: {
                    connectionTypeSelection.visible = true
                }
            }

            BasicButtonType {
                Layout.fillWidth: true
                Layout.topMargin: 8
                Layout.leftMargin: 16
                Layout.rightMargin: 16

                defaultColor: "transparent"
                hoveredColor: Qt.rgba(1, 1, 1, 0.08)
                pressedColor: Qt.rgba(1, 1, 1, 0.12)
                disabledColor: "#878B91"
                textColor: "#D7D8DB"
                borderWidth: 1

                text: qsTr("I have nothing")

                onClicked: Qt.openUrlExternally("https://ru-docs.amnezia.org/guides/hosting-instructions")
            }
        }

        ConnectionTypeSelectionDrawer {
            id: connectionTypeSelection
        }
    }

    BusyIndicatorType {
        id: busyIndicator
        anchors.centerIn: parent
        z: 1
    }
}