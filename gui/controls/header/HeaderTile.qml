import QtQuick 2.15
import QtQuick.Controls 2.15
import AudioMixer

Item {
    id: tile
    implicitWidth: 96
    implicitHeight: 36

    property string title
    property var model

    signal optionTriggered(string optionId)

    Rectangle {
        id: base
        anchors.fill: parent
        radius: 3
        color: Themes.bgMain
        border.color: popup.visible ? Themes.borderHover : Themes.borderIdle

        Text {
            anchors.centerIn: parent
            text: tile.title
            color: "white"
            font.pixelSize: 12
        }

        MouseArea {
            anchors.fill: parent
            onClicked: popup.open()
        }
    }

    Popup {
        id: popup
        x: tile.mapToItem(null, 0, tile.height).x
        y: tile.mapToItem(null, 0, tile.height).y
        width: 160
        modal: false
        focus: true

        background: Rectangle {
            radius: 4
            color: Themes.bgMain
            border.color: Themes.borderHover
        }

        Column {
            spacing: 2

            Repeater {
                model: tile.model
                delegate: HeaderOption {
                    text: model.label
                    optionId: model.actionId
                    onTriggered: {
                        popup.close()
                        tile.optionTriggered(optionId)
                    }
                }
            }
        }
    }
}
