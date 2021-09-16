import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import PageEnum 1.0
import "./"
import "../Controls"
import "../Config"
import "InstallSettings"

PageBase {
    id: root
    page: PageEnum.NewServerProtocols
    logic: NewServerProtocolsLogic

    BackButton {
        id: back
    }
    Caption {
        id: caption
        text: qsTr("Select VPN protocols")
    }

    BlueButtonType {
        id: pushButtonConfigure
        enabled: container_selector.selectedIndex > 0
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height - 60
        width: parent.width - 40
        height: 40
        text: qsTr("Setup server")
        onClicked: {
            NewServerProtocolsLogic.pushButtonConfigureClicked()
        }
    }

    BlueButtonType {
        id: pb_add_container
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: caption.bottom
        anchors.topMargin: 10

        width: parent.width - 40
        height: 40
        text: qsTr("Select protocol container")
        font.pixelSize: 16
        onClicked: container_selector.visible ? container_selector.close() : container_selector.open()

    }

    SelectContainer {
        id: container_selector
    }

    Column {
        id: c1
        visible: container_selector.selectedIndex > 0
        width: parent.width
        anchors.top: pb_add_container.bottom
        anchors.topMargin: 10

        Caption {
            font.pixelSize: 22
            text: UiLogic.containerName(container_selector.selectedIndex)
        }

        Text {
            width: parent.width
            anchors.topMargin: 10
            padding: 10

            font.family: "Lato"
            font.styleName: "normal"
            font.pixelSize: 16
            color: "#181922"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.Wrap

            text: UiLogic.containerDesc(container_selector.selectedIndex)
        }
    }



    Rectangle {
        id: frame_settings
        visible: container_selector.selectedIndex > 0
        width: parent.width
        anchors.top: c1.bottom
        anchors.topMargin: 10

        border.width: 1
        border.color: "lightgray"
        anchors.bottomMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        radius: 2
        Grid {
            id: grid
            visible: container_selector.selectedIndex > 0
            anchors.fill: parent
            columns: 2
            horizontalItemAlignment: Grid.AlignHCenter
            verticalItemAlignment: Grid.AlignVCenter
            topPadding: 5
            leftPadding: 10
            spacing: 5


            LabelType {
                width: 130
                text: qsTr("Port (TCP/UDP)")
            }
            TextFieldType {
                width: parent.width - 130 - parent.spacing - parent.leftPadding * 2
                text: NewServerProtocolsLogic.lineEditOpenvpnPortText
                onEditingFinished: {
                    NewServerProtocolsLogic.lineEditOpenvpnPortText = text
                }
            }
            LabelType {
                width: 130
                text: qsTr("Protocol")
            }
            ComboBoxType {
                width: parent.width - 130 - parent.spacing - parent.leftPadding * 2
                model: [
                    qsTr("udp"),
                    qsTr("tcp"),
                ]
                currentIndex: {
                    for (let i = 0; i < model.length; ++i) {
                        if (NewServerProtocolsLogic.comboBoxOpenvpnProtoText === model[i]) {
                            return i
                        }
                    }
                    return -1
                }
                onCurrentTextChanged: {
                    NewServerProtocolsLogic.comboBoxOpenvpnProtoText = currentText
                }
            }
        }
    }









//    ScrollView {
//        id: scrollView
//        width: parent.width - 40
//        anchors.horizontalCenter: parent.horizontalCenter

//        anchors.top: pb_add_container.bottom
//        anchors.topMargin: 10

//        anchors.bottom: pushButtonConfigure.top
//        anchors.bottomMargin: 10

//        clip: true
//        Column {
//            width: scrollView.width
//            anchors.horizontalCenter: parent.horizontalCenter

//            spacing: 5
//            InstallSettingsBase {
//                containerDescription: qsTr("OpenVPN and ShadowSocks\n with masking using Cloak plugin")
//                onContainerChecked: NewServerProtocolsLogic.checkBoxCloakChecked = checked

//                LabelType {
//                    width: 130
//                    height: (parent.height - parent.spacing - parent.topPadding * 2) / 2
//                    text: qsTr("Port (TCP)")
//                }
//                TextFieldType {
//                    width: parent.width - 130 - parent.spacing - parent.leftPadding * 2
//                    height: (parent.height - parent.spacing - parent.topPadding * 2) / 2
//                    text: NewServerProtocolsLogic.lineEditCloakPortText
//                    onEditingFinished: {
//                        NewServerProtocolsLogic.lineEditCloakPortText = text
//                    }
//                }
//                LabelType {
//                    width: 130
//                    height: (parent.height - parent.spacing - parent.topPadding * 2) / 2
//                    text: qsTr("Fake Web Site")
//                }
//                TextFieldType {
//                    width: parent.width - 130 - parent.spacing - parent.leftPadding * 2
//                    height: (parent.height - parent.spacing - parent.topPadding * 2) / 2
//                    text: NewServerProtocolsLogic.lineEditCloakSiteText
//                    onEditingFinished: {
//                        NewServerProtocolsLogic.lineEditCloakSiteText = text
//                    }
//                }

//            }

//            InstallSettingsBase {
//                containerDescription: qsTr("ShadowSocks")
//                onContainerChecked: NewServerProtocolsLogic.checkBoxSsChecked = checked

//                LabelType {
//                    width: 130
//                    height: (parent.height - parent.spacing - parent.topPadding * 2) / 2
//                    text: qsTr("Port (TCP)")
//                }
//                TextFieldType {
//                    width: parent.width - 130 - parent.spacing - parent.leftPadding * 2
//                    height: (parent.height - parent.spacing - parent.topPadding * 2) / 2
//                    text: NewServerProtocolsLogic.lineEditSsPortText
//                    onEditingFinished: {
//                        NewServerProtocolsLogic.lineEditSsPortText = text
//                    }
//                }
//                LabelType {
//                    width: 130
//                    height: (parent.height - parent.spacing - parent.topPadding * 2) / 2
//                    text: qsTr("Encryption")
//                }
//                ComboBoxType {
//                    width: parent.width - 130 - parent.spacing - parent.leftPadding * 2
//                    height: (parent.height - parent.spacing - parent.topPadding * 2) / 2
//                    model: [
//                        qsTr("chacha20-ietf-poly1305"),
//                        qsTr("xchacha20-ietf-poly1305"),
//                        qsTr("aes-256-gcm"),
//                        qsTr("aes-192-gcm"),
//                        qsTr("aes-128-gcm")
//                    ]
//                    currentIndex: {
//                        for (let i = 0; i < model.length; ++i) {
//                            if (NewServerProtocolsLogic.comboBoxSsCipherText === model[i]) {
//                                return i
//                            }
//                        }
//                        return -1
//                    }
//                    onCurrentTextChanged: {
//                        NewServerProtocolsLogic.comboBoxSsCipherText = currentText
//                    }
//                }

//            }

//            InstallSettingsBase {
//                containerDescription: qsTr("OpenVPN")
//                onContainerChecked: NewServerProtocolsLogic.checkBoxOpenVpnChecked = checked

//                LabelType {
//                    width: 130
//                    height: (parent.height - parent.spacing - parent.topPadding * 2) / 2
//                    text: qsTr("Port (TCP/UDP)")
//                }
//                TextFieldType {
//                    width: parent.width - 130 - parent.spacing - parent.leftPadding * 2
//                    height: (parent.height - parent.spacing - parent.topPadding * 2) / 2
//                    text: NewServerProtocolsLogic.lineEditOpenvpnPortText
//                    onEditingFinished: {
//                        NewServerProtocolsLogic.lineEditOpenvpnPortText = text
//                    }
//                }
//                LabelType {
//                    width: 130
//                    height: (parent.height - parent.spacing - parent.topPadding * 2) / 2
//                    text: qsTr("Protocol")
//                }
//                ComboBoxType {
//                    width: parent.width - 130 - parent.spacing - parent.leftPadding * 2
//                    height: (parent.height - parent.spacing - parent.topPadding * 2) / 2
//                    model: [
//                        qsTr("udp"),
//                        qsTr("tcp"),
//                    ]
//                    currentIndex: {
//                        for (let i = 0; i < model.length; ++i) {
//                            if (NewServerProtocolsLogic.comboBoxOpenvpnProtoText === model[i]) {
//                                return i
//                            }
//                        }
//                        return -1
//                    }
//                    onCurrentTextChanged: {
//                        NewServerProtocolsLogic.comboBoxOpenvpnProtoText = currentText
//                    }
//                }

//            }

//            InstallSettingsBase {
//                visible: false
//                containerDescription: qsTr("WireGuard")
//                onContainerChecked: NewServerProtocolsLogic.checkBoxWireGuardChecked = checked

//                LabelType {
//                    width: 130
//                    height: (parent.height - parent.spacing - parent.topPadding * 2)
//                    text: qsTr("Port (UDP)")
//                }
//                TextFieldType {
//                    width: parent.width - 130 - parent.spacing - parent.leftPadding * 2
//                    height: (parent.height - parent.spacing - parent.topPadding * 2)
//                    text: "32767"
//                }
//            }
//        }
//    }
}