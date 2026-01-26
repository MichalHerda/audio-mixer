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

    property int hoveredChannelIndex: -1
    property int selectedChannelIndex: -1
    property var channelModel: [                                                        // mock !
        "Kick Drum          Mic 1",
        "Snare Drum         Mic 2",
        "Hi-Hat             Mic 3",
        "Bass Guitar        DI   ",
        "Electric Guitar L  Mic 4",
        "Electric Guitar R  Mic 5",
        "Lead Vocal         Mic 6",
        "Backing Vocal      Mic 7"
    ]

    Flickable {
        id: flick
        anchors.fill: parent

        contentWidth: channelsRow.width
        contentHeight: height

        flickableDirection: Flickable.HorizontalFlick
        clip: true

        interactive: !appMixer.resizing

        Row {
            id: channelsRow
            spacing: 5
            anchors.left: parent.left

            Repeater {
                model: mixer.channelModel                                                // mock
                ChannelStrip {
                    height: mixer.height
                    channelDisplayedName: modelData
                    channelIndex: index
                    hovered: mixer.hoveredChannelIndex === index
                    selected: mixer.selectedChannelIndex === index

                    HoverHandler {
                        onHoveredChanged: {
                            if (hovered)
                                mixer.hoveredChannelIndex = channelIndex
                            else if (mixer.hoveredChannelIndex === channelIndex)
                                mixer.hoveredChannelIndex = -1
                        }
                    }

                    TapHandler {
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        onTapped: function(event, button) {

                            if (button === Qt.LeftButton) {
                                if (mixer.selectedChannelIndex === channelIndex)
                                    mixer.selectedChannelIndex = -1
                                else
                                    mixer.selectedChannelIndex = channelIndex
                            }

                            else if (button === Qt.RightButton) {
                                mixer.selectedChannelIndex = channelIndex
                            }

                            console.log(
                                "clicked channel:", channelIndex,
                                "selected:", mixer.selectedChannelIndex
                            )
                        }
                    }

                }
            }
        }
    }
}
