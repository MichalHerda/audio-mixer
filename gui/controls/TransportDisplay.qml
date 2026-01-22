import QtQuick 2.15

Rectangle {
    id: background
    implicitWidth: 200
    implicitHeight: 80
    color: "#1e1e1e"

    Column {
        spacing: 4
        padding: 2
        anchors.fill: parent

        MixerMiniDisplay {
            text: Qt.formatTime(state.position * 1000, "mm:ss.zzz")
            autoScroll: false
        }

        MixerMiniDisplay {
            text: state.playing ? "PLAY" :
                  state.paused ? "PAUSE" :
                  "STOP"
            autoScroll: false
        }
    }
}

