import QtQuick 2.15
import "../../controls"

Item {
    id: root
    implicitHeight: 48
    implicitWidth: 144

    property bool mute: false
    property bool solo: false

    signal muteToggled(bool mute)
    signal soloToggled(bool solo)

    Row {
        id: muteSoloRow
        anchors.fill: parent
        spacing: parent.width * 0.08
        padding: parent.width * 0.04

        MixerButton {
            id: soloButton
            width: parent.width * 0.44
            buttonColorBorderPressed: "green"
            lightColorOn: "lightGreen"
            buttonText: "SOLO"

            isOn: root.solo

            onMixerButtonClicked: {
                root.soloToggled(!root.solo)
            }
        }

        MixerButton {
            id: muteButton
            width: parent.width * 0.44
            buttonColorBorderPressed: "tomato"
            lightColorOn: "red"
            buttonText: "MUTE"

            isOn: root.mute

            onMixerButtonClicked: {
                root.muteToggled(!root.mute)
            }
        }
    }
}
