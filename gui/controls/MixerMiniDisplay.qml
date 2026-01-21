import QtQuick 2.15
import QtQuick.Shapes 1.10

Item {
    id: root
    implicitHeight: 36
    implicitWidth: 136
    clip: true

    property string text: "Audio Mixer - UI designed by Michal Herda"
    property bool autoScroll: true
    property int scrollSpeed: 40
    property int pauseMs: 800

    property real horizontalPaddingRatio: 0.05
    readonly property real hPadding: width * horizontalPaddingRatio
    readonly property real scrollAreaWidth: width - 2 * hPadding

    property bool highlighted: hoverArea.containsMouse
    property real highlightPhase: 0.0

    Rectangle {
        id: base
        anchors.fill: parent
        radius: 3
        color: "#0c0c0c"

        border.color: highlighted ? "lightskyblue" : "#222"
        border.width: highlighted ? 2 : 1

        Behavior on border.color {
            ColorAnimation { duration: 200 }
        }

        Behavior on border.width {
            NumberAnimation { duration: 150 }
        }
    }

    Rectangle {
        anchors.fill: parent
        radius: 3
        visible: highlighted
        opacity: highlightPhase * 0.15
        z: 1

        gradient: RadialGradient {
            centerX: 0.5
            centerY: 0.5
            GradientStop { position: 0.0; color: "#00ff9c" }
            GradientStop { position: 1.0; color: "transparent" }
        }
    }

    Item {
        id: viewport
        x: root.hPadding
        width: root.scrollAreaWidth
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height
        clip: true

        Text {
            id: label
            text: root.text
            color: "#00ff9c"
            font.pixelSize: 12
            font.family: "Monospace"
            verticalAlignment: Text.AlignVCenter
            y: (parent.height - height) / 2

            x: scrollAnim.running ? scrollX : 0
            clip: true
        }
    }

    property real scrollX: 0
    readonly property bool needsScroll: label.width > scrollAreaWidth

    SequentialAnimation {
        id: scrollAnim
        running: root.autoScroll && root.needsScroll
        loops: Animation.Infinite

        PauseAnimation { duration: root.pauseMs }

        NumberAnimation {
            target: root
            property: "scrollX"
            from: 0
            to: -(label.width - root.scrollAreaWidth)
            duration: (label.width / root.scrollSpeed) * 1000
            easing.type: Easing.Linear
        }

        PauseAnimation { duration: root.pauseMs }

        NumberAnimation {
            target: root
            property: "scrollX"
            from: -(label.width - root.scrollAreaWidth)
            to: 0
            duration: (label.width / root.scrollSpeed) * 500
            easing.type: Easing.Linear
        }
    }

    MouseArea {
        id: hoverArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
    }

    SequentialAnimation on highlightPhase {
        running: highlighted
        loops: Animation.Infinite

        NumberAnimation {
            from: 0.0
            to: 1.0
            duration: 1200
            easing.type: Easing.InOutSine
        }
        NumberAnimation {
            from: 1.0
            to: 0.0
            duration: 1200
            easing.type: Easing.InOutSine
        }
    }

}

