import QtQuick 2.15
import QtQuick.Controls 2.15
import AudioMixer

Item {
    id: tile
    implicitWidth: 96
    implicitHeight: 36

    property int tileIndex: -1
    property string title
    property var model

    property bool open: false

    signal optionTriggered(string optionId)
    signal clicked()
    signal hovered(bool hovered)

    Rectangle {
        id: base
        anchors.fill: parent
        radius: 3

        color: open ? Themes.bgHover : Themes.bgMain
        border.color: open ? Themes.borderHover : Themes.borderIdle
        border.width: open ? 2 : 1

        Behavior on color { ColorAnimation { duration: Themes.animFast } }
        Behavior on border.width { NumberAnimation { duration: 120 } }

        Text {
            anchors.centerIn: parent
            text: tile.title
            color: "white"
            font.pixelSize: 12
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: tile.hovered(true)
        onExited: tile.hovered(false)
        onClicked: tile.clicked()
    }

    onOpenChanged: {
        if (open)
            popup.open()
        else
            popup.close()
    }

    Popup {
        id: popup
        modal: false
        focus: true
        width: 160
        padding: 0

        x: tile.mapToItem(null, 0, tile.height).x
        y: tile.mapToItem(null, 0, tile.height).y

        background: Rectangle {
            radius: 4
            color: Themes.bgMain
            border.color: Themes.borderHover
        }

        contentItem: Column {
            id: popupColumn
            spacing: 2

            Repeater {
                model: tile.model
                delegate: HeaderOption {
                    width: popupColumn.width
                    text: model.label
                    optionId: model.actionId
                    onTriggered: tile.optionTriggered(optionId)
                }
            }
        }
    }
}
