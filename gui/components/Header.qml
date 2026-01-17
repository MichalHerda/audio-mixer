import QtQuick 2.15

Item {
    id: container

    Rectangle {
        id: root
        anchors.fill: parent
        color: Theme.backgroundColor

        border {
            color: Theme.borderColor
            width: parent.width * 0.005
        }
    }
}
