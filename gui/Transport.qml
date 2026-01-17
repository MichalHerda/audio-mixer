import QtQuick 2.15

Item {
    id: container

    Rectangle {
        id: root
        anchors.fill: parent
        color: "darkgrey"

        border {
            color: "grey"
            width: parent.width * 0.005
        }
    }
}
