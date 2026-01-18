import QtQuick 2.15
import "../sections"

Item {
    id: channel
    //width: 100
    //implicitHeight: 300

    Rectangle {
        anchors.fill: parent
        color: "#1e1e1e"
        border.color: "#444"
        border.width: 1
    }

    Column {
        id: channelColumn
        anchors.fill: parent
        anchors.margins: 8
        spacing: 16

        EQSection {
            height: channelColumn.height
            width: channelColumn.width
        }
    }
}
