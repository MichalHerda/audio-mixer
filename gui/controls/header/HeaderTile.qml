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
    property bool headerHovered: false

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

    MouseArea {
        id: globalMouseTracker
        parent: Overlay.overlay
        enabled: !headerHovered
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
        visible: popup.visible

        onPositionChanged: function(mouse) {
            if (!popup.visible)
                return

            if (tile.isCursorFarEnough(mouse.x, mouse.y)) {
                popup.close()
            }
        }
    }

    function isCursorFarEnough(globalX, globalY) {
        const popupW = popup.width
        const popupH = popup.height

        const tilePos = tile.mapToItem(null, 0, 0)
        const popupPos = { x: popup.x, y: popup.y }

        const left   = Math.min(tilePos.x, popupPos.x) - popupW
        const right  = Math.max(tilePos.x + tile.width, popupPos.x + popup.width) + popupW
        const top    = Math.min(tilePos.y, popupPos.y) - popupH
        const bottom = Math.max(tilePos.y + tile.height, popupPos.y + popup.height) + popupH

        return globalX < left
            || globalX > right
            || globalY < top
            || globalY > bottom
    }
}
