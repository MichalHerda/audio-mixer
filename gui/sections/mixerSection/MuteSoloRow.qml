import QtQuick 2.15
import "../../controls"

Item {
    id: root
    implicitHeight: 48
    implicitWidth: 144

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
        }

        MixerButton {
            id: muteButton
            width: parent.width * 0.44
            buttonColorBorderPressed: "tomato"
            lightColorOn: "red"
            buttonText: "MUTE"
        }
    }
}
