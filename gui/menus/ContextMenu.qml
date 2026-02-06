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

    MouseArea {
        id: globalMouseTracker
        parent: popup.parent   // Overlay.overlay
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
        propagateComposedEvents: true
        visible: popup.visible

        onPositionChanged: function(mouse) {
            if (!popup.visible)
                return

            if (popup.isCursorFarEnough(mouse.x, mouse.y)) {
                popup.close()
            }
        }
    }

    function openAt(globalX, globalY) {
        const overlay = popup.parent

            let px = globalX
            let py = globalY

            // vertical:
            if (px + width > overlay.width) {
                px = globalX - width
            }

            // horizontal:
            if (py + height > overlay.height) {
                py = globalY - height
            }

            // protection (do not go beyond the screen on the other side):
            px = Math.max(0, px)
            py = Math.max(0, py)

            x = px
            y = py
            open()
    }

    function isCursorFarEnough(globalX, globalY) {
        const thresholdX = width * 0.5
        const thresholdY = height * 0.5

        const left   = x - thresholdX
        const right  = x + width + thresholdX
        const top    = y - thresholdY
        const bottom = y + height + thresholdY

        return globalX < left
            || globalX > right
            || globalY < top
            || globalY > bottom
    }
}
