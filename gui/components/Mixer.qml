import QtQuick 2.15
import AudioMixer

Item {
    id: container

    Rectangle {
        id: root
        anchors.fill: parent
        color: Themes.backgroundColor

        border {
            color: Themes.borderColor
            width: parent.width * 0.005
        }
    }
}
