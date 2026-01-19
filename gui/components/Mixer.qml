import QtQuick 2.15
import QtQuick.Layouts
import AudioMixer
import "../components"

Rectangle {
    id: mixer
    color: Themes.backgroundColor
    border {
        color: Themes.borderColor
        width: 1
    }

    Flickable {
        id: flick
        anchors.fill: parent

        contentWidth: channelsRow.width
        contentHeight: height

        flickableDirection: Flickable.HorizontalFlick
        clip: true

        Row {
            id: channelsRow
            spacing: 5
            anchors.left: parent.left

            Repeater {
                model: 8                                                // mock
                ChannelStrip {
                    height: mixer.height
                    width: Math.max(minW, Math.min(maxW, mixer.width * 0.2))
                }
            }

            Item {
                id: separator
                Layout.fillWidth: true
            }
        }
    }
}
