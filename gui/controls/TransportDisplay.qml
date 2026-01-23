import QtQuick 2.15

Rectangle {
    id: background
    implicitWidth: 200
    implicitHeight: 80
    //color: "#1e1e1e"
    color: "transparent"

    Column {
        spacing: 4
        padding: 2
        anchors.fill: parent

        MixerMiniDisplay {
            text: "This is demo version currently under development"                                          //TODO: Qt.formatTime(state.position * 1000, "mm:ss.zzz")
            autoScroll: true
        }

        MixerMiniDisplay {
            text: state.playing ? "PLAY" :
                  state.paused ? "PAUSE" :
                  "Audio mixer - for now, It is not planned to go beyond UI and integration with the model"
            autoScroll: true
        }
    }
}

