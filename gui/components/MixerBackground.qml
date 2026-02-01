import QtQuick 2.15
import AudioMixer

Item {
    id: root

    implicitHeight: 600
    implicitWidth: 164
    width: Math.max(implicitWidth, parent.width - parent.childrenRect.width)

    property bool selected: false
    property bool hovered: false
    property bool resizing: false
    property bool handleHovered: false

    readonly property bool highlighted: hovered || handleHovered || resizing
    property real highlightPhase: 0.0
    property bool shine: true

    signal contextMenuRequested(real x, real y)
    signal addTrackRequested()

    Rectangle {
        id: bg
        anchors.fill: parent

        color: root.hovered
               ? Themes.bghovered
               : highlighted
                 ? Themes.bgHover
                 : Themes.bgMain

        border.color: root.selected
                      ? Themes.borderSelected
                      : root.hovered
                        ? Themes.borderhovered
                        : highlighted
                          ? Qt.lighter(Themes.borderHover, 1.4)
                          : Themes.borderIdle

        border.width: root.selected ? 3 : highlighted ? 2 : 1

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

    HoverHandler {
        onHoveredChanged: root.hovered = hovered
    }

    SequentialAnimation on highlightPhase {
        running: highlighted && shine
        loops: Animation.Infinite

        NumberAnimation {
            from: 0.2
            to: 0.45
            duration: 420
            easing.type: Easing.InOutSine
        }

        NumberAnimation {
            from: 0.45
            to: 0.2
            duration: 420
            easing.type: Easing.InOutSine
        }
    }
}
