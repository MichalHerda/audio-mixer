import QtQuick 2.15

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

    Rectangle {
        anchors.fill: parent
        radius: 3
        color: "#0c0c0c"
        border.color: "#222"
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

}

