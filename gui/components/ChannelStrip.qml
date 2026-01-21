import QtQuick 2.15

import "../sections"
import "../controls"

Item {
    id: channel
    implicitHeight: 600
    implicitWidth: 64
    property int channelSpacing: 16
    property int channelPadding: 4

    readonly property real minW: 80
    readonly property real maxW: 150

    property alias channelDisplayedName: channelName.text

    property int channelIndex: -1
    property bool selected: false
    property bool hovered: false

    HoverHandler {
        id: hoverHandler
        acceptedDevices: PointerDevice.Mouse
        onHoveredChanged: channel.hovered = hovered
    }

    Rectangle {
        anchors.fill: parent

        color: channel.selected ? "#2b3a55" : channel.hovered ? "#233047" : "#1e1e1e"
        border.color: channel.selected ? "#4da3ff" : channel.hovered ? "#6fb6ff" : "#444"
        border.width: channel.selected ? 2 : 1

        Behavior on color {
            ColorAnimation { duration: 150 }
        }
        Behavior on border.color {
            ColorAnimation { duration: 150 }
        }
    }

    Column {
        id: channelColumn
        anchors.horizontalCenter: channel.horizontalCenter
        spacing: channelSpacing
        padding: channelPadding
        topPadding: channelPadding * 2

        MixerMiniDisplay {
            id: channelName
            width: channel.width - channelPadding * 4
            anchors.horizontalCenter: channelColumn.horizontalCenter
            text: "Audio Mixer UI - designed by Michal Herda 2026"
        }

        MuteSoloRow {
            id: muteSoloRow
            width: channel.width - channelPadding * 2
            anchors.horizontalCenter: channelColumn.horizontalCenter
        }

        Knob {
            id: gainKnob
            anchors.horizontalCenter: channelColumn.horizontalCenter
            label: "GAIN"
            indicatorColor: "red"
            from: 20
            to: 20000
            value: 1000
        }

        EQSection {
            id: eqSection
            anchors.horizontalCenter: channelColumn.horizontalCenter
        }

        VolumeFader {
            id: volumeFader
            anchors.horizontalCenter: channelColumn.horizontalCenter
        }
    }
}
