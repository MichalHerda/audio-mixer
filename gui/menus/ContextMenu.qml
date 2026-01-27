import QtQuick 2.15
import QtQuick.Controls 2.15
import AudioMixer
import "../controls/header"

Popup {
    id: popup
    parent: Overlay.overlay
    modal: false
    focus: true
    padding: 0
    height: 120
    width: 180

    property var model
    signal menuAction(string actionId)

    background: Rectangle {
        radius: 4
        color: Themes.bgMain
        border.color: Themes.borderHover
        border.width: 1
    }

    contentItem: Column {
        width: popup.width
        height: popup.height
        spacing: 2

        Repeater {
            model: popup.model
            delegate: HeaderOption {
                width: popup.width
                height: popup.height * 0.25
                text: model.label
                optionId: model.actionId
                onTriggered: {
                    popup.close()
                    popup.menuAction(optionId)
                }
            }
        }
    }

    function openAt(globalX, globalY) {
        x = globalX
        y = globalY
        open()
    }
}
