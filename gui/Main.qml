import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import AudioMixer

import "./components"

Window {
    id: root
    width: 960
    height: 880
    minimumHeight: 600
    minimumWidth: 320
    visible: true
    title: qsTr("Audio Mixer")

    SplitView {
        id: appLayout
        anchors.fill: parent
        orientation: Qt.Vertical

        Header {
            id: appHeader
            SplitView.preferredHeight: 40
            SplitView.minimumHeight: 35
            SplitView.maximumHeight: 70

            onMenuAction: function(id) {
                console.log("Menu action:", id)
                // TODO:
                // appController.handleMenuAction(id)
            }
        }

        Transport {
            id: appTransport
            SplitView.preferredHeight: 85
            SplitView.minimumHeight: 80
            SplitView.maximumHeight: 120

            HoverHandler {
                onHoveredChanged: {
                    appTransport.hovered = hovered
                }
            }
        }

        Mixer {
            id: appMixer
            SplitView.fillHeight: true
            SplitView.minimumHeight: 100
        }
    }
}
