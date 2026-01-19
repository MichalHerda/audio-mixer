import QtQuick 2.15

import "../sections"
import "../controls"

Item {
    id: channel
    implicitHeight: 600
    implicitWidth: 64
    property int channelSpacing: 8
    property int channelPadding: 4

    readonly property real minW: 80
    readonly property real maxW: 150

    Rectangle {
        anchors.fill: parent
        color: "#1e1e1e"
        border.color: "#444"
        border.width: 1
    }

    Column {
        id: channelColumn
        anchors.horizontalCenter: channel.horizontalCenter
        spacing: channelSpacing
        padding: channelPadding

        MixerButton {
            id: mixerButton
        }

        Knob {
            id: gainKnob
            label: "GAIN"
            indicatorColor: "red"
            from: 20
            to: 20000
            value: 1000
        }

        EQSection {
            id: eqSection
        }

        VolumeFader {
            id: volumeFader
        }
    }
}
