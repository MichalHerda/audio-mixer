import QtQuick 2.15
import "../../controls"

Rectangle {
    id: background
    implicitWidth: 436
    implicitHeight: 40
    //color: "#1e1e1e"
    color: "transparent"

    Row {
        anchors.fill: parent
        spacing: 8
        padding: 2

        TransportButton {
            buttonText: "REW"
            mode: TransportButton.Momentary
            //onClicked: state.rewind()
        }

        TransportButton {
            buttonText: "PLAY"
            //isOn: state.playing
            //onClicked: state.play()
        }

        TransportButton {
            buttonText: "PAUSE"
            //isOn: state.paused
            //onClicked: state.pause()
        }

        TransportButton {
            buttonText: "REC"
            mode: TransportButton.Momentary
            //onClicked: state.stop()
        }

        TransportButton {
            buttonText: "STOP"
            enabled: false                                  // TODO
            //isOn: state.recording
        }

        TransportButton {
            buttonText: "LOOP"
            //isOn: state.loop
            //onClicked: state.loop = !state.loop
        }
    }
}

