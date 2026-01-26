import QtQuick 2.15

import "../sections"
import "../controls"
import AudioMixer

Item {
    id: channel
    implicitHeight: 600
    implicitWidth: 164
    property int channelSpacing: 16
    property int channelPadding: 4

    readonly property real minW: 80
    readonly property real maxW: 150
    property real stripWidth: implicitWidth
    width: stripWidth

    property alias channelDisplayedName: channelName.text

    property int channelIndex: -1
    property bool selected: false
    property bool hovered: false
    property bool resizing: false

    property bool handleHovered: false
    readonly property bool highlighted: hovered || handleHovered || resizing
    property real highlightPhase: 0.0
    property bool shine: true

    Rectangle {
        id: bg
        anchors.fill: parent

        color: channel.hovered
               ? Themes.bghovered
               : highlighted
                 ? Themes.bgHover
                 : Themes.bgMain

        border.color: channel.selected
                      ? Themes.borderSelected
                      : channel.hovered
                        ? Themes.borderhovered
                        : highlighted
                          ? Qt.lighter(Themes.borderHover, 1.4)
                          : Themes.borderIdle

        border.width: channel.selected ? 3 : highlighted ? 2 : 1

        /* subtle glow overlay */
        Rectangle {
            anchors.fill: parent
            visible: highlighted && shine
            opacity: highlightPhase * 0.35
            color: "white"
        }

        Behavior on color { ColorAnimation { duration: Themes.animFast } }
        Behavior on border.color { ColorAnimation { duration: Themes.animFast } }
        Behavior on border.width { NumberAnimation { duration: 120 } }
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

        Knob {
            id: panKnob
            anchors.horizontalCenter: channelColumn.horizontalCenter
            label: "PAN"
            indicatorColor: "white"
            from: 20
            to: 20000
            value: 9990
        }

        VolumeFader {
            id: volumeFader
            anchors.horizontalCenter: channelColumn.horizontalCenter
        }        
    }

    Rectangle {
        id: resizeHandle
        width: 8
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        color: "transparent"
        z: 100

        DragHandler {
            id: drag
            target: null
            xAxis.enabled: true
            yAxis.enabled: false
            grabPermissions: PointerHandler.TakeOverForbidden

            property real startWidth

            onActiveChanged: {
                channel.resizing = active
                if (active)
                    startWidth = channel.stripWidth
            }

            onTranslationChanged: {
                channel.stripWidth = Math.max(
                    channel.minW,
                    Math.min(channel.maxW, startWidth + translation.x)
                )
            }
        }

        HoverHandler {
            cursorShape: Qt.SizeHorCursor
            onHoveredChanged: channel.handleHovered = hovered
        }
    }

    SequentialAnimation on highlightPhase {
        running: highlighted && shine
        loops: Animation.Infinite

        NumberAnimation {
            from: 0.2
            to: resizing ? 0.6 : 0.45
            duration: resizing ? 220 : 420
            easing.type: Easing.InOutSine
        }

        NumberAnimation {
            from: resizing ? 0.6 : 0.45
            to: 0.2
            duration: resizing ? 220 : 420
            easing.type: Easing.InOutSine
        }
    }
}
