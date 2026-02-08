import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls
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
    property bool backgroundSelected: false

    ContextMenu {
        id: trackContextMenu
        model: TrackMenuModel{}

        onMenuAction: function(actionId) {
            console.log("Track context action:", actionId,
                        "on channel:", selectedChannelIndex)
            appController.handleAction(actionId, selectedChannelIndex)
        }
    }

    ContextMenu {
        id: backgroundContextMenu
        model: BackgroundTrackMenuModel {}

        onMenuAction: function(actionId) {
            console.log("Track context action:", actionId,
                        "on mixer background")
            appController.handleAction(actionId, selectedChannelIndex)
        }
    }


    Flickable {
        id: flick
        anchors.fill: parent

        contentWidth: channelsRow.childrenRect.width
        contentHeight: height

        flickableDirection: Flickable.HorizontalFlick
        clip: true

        interactive: !appMixer.resizing

        ScrollBar.horizontal: ScrollBar {
            policy: ScrollBar.AlwaysOn
            implicitHeight: 18
        }

        Row {
            id: channelsRow
            width: childrenRect.width
            spacing: 5
            anchors.left: parent.left

            Repeater {
                id: channelsRepeater
                model: appController.mixerModel
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
                                if (mixer.selectedChannelIndex === channelIndex) {
                                    mixer.selectedChannelIndex = -1
                                }
                                else {
                                    mixer.selectedChannelIndex = channelIndex
                                    mixer.backgroundSelected = false
                                }
                            }

                            else if (button === Qt.RightButton) {
                                console.log("right click")
                                mixer.selectedChannelIndex = channelIndex
                                mixer.backgroundSelected = false
                                trackContextMenu.openAt(event.scenePosition.x, event.scenePosition.y)
                                onOpened: console.log("trackContextMenu opened at", event.scenePosition.x, event.scenePosition.y)
                            }
                        }
                    }
                }
            }

            MixerBackground {
                id: mixerBackground
                height: mixer.height
                width: Math.max(
                   flick.width - channelsRepeater.width,
                   implicitWidth
               )
                selected: mixer.backgroundSelected

                TapHandler {
                    acceptedButtons: Qt.LeftButton | Qt.RightButton

                    onTapped: function(event, button) {
                        if (button === Qt.LeftButton) {
                            mixer.backgroundSelected = !mixer.backgroundSelected
                            mixer.selectedChannelIndex = -1  // odznacz kanały
                        }
                        else if (button === Qt.RightButton) {
                            mixer.backgroundSelected = true
                            mixer.selectedChannelIndex = -1
                            backgroundContextMenu.openAt(event.scenePosition.x, event.scenePosition.y)
                            onOpened: console.log("backgroundContextMenu popup opened at", event.scenePosition.x, event.scenePosition.y)
                        }
                    }
                }
            }
        }
    }

    function clearSelection() {
        selectedChannelIndex = -1
        backgroundSelected = false
    }
}
