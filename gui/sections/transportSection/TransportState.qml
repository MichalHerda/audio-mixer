import QtQuick 2.15

QtObject {
    id: state

    property bool playing: false
    property bool paused: false
    property bool recording: false
    property bool loop: false

    property real position: 0.0         // seconds
    property real speed: 1.0            // 1 = normal

    signal play()
    signal stop()
    signal pause()
    signal record()
    signal rewind()
    signal fastForward()
}
