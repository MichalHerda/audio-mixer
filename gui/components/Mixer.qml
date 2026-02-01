import QtQuick 2.15
import QtQuick.Layouts
import AudioMixer
import "../components"
import "../menus"

Rectangle {
    id: mixer
    color: Themes.backgroundColor
    border {
        color: Themes.borderColor
        width: 1
    }

    property int hoveredChannelIndex: -1
    property int selectedChannelIndex: -1
    /*
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
    */
    ContextMenu {
        id: trackContextMenu
        model: TrackMenuModel{}

        onMenuAction: function(actionId) {
            console.log("Track context action:", actionId,
                        "on channel:", selectedChannelIndex)
            // appController.handleTrackAction(actionId, selectedChannelIndex)
        }
    }

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
                model: appController.mixerModel     //mixer.channelModel                                                // mock
                ChannelStrip {
                    height: mixer.height
                    channelIndex: index
                    channelModel: model.channel
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
                                mixer.selectedChannelIndex =
                                    mixer.selectedChannelIndex === channelIndex
                                    ? -1
                                    : channelIndex
                            }

                            else if (button === Qt.RightButton) {
                                console.log("right click")
                                mixer.selectedChannelIndex = channelIndex
                                trackContextMenu.openAt(
                                    event.scenePosition.x,
                                    event.scenePosition.y
                                )
                                onOpened: console.log("popup opened at", event.scenePosition.x, event.scenePosition.y)
                            }
                        }
                    }
                }
            }
        }
    }
}
