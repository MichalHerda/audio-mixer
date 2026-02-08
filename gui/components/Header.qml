import QtQuick 2.15
import QtQuick.Layouts 1.15
import "../components"
import "../controls/header"
import AudioMixer

Rectangle {
    id: header

    signal menuAction(string actionId)
    color: Themes.backgroundColor
    border.color: Themes.borderColor
    property int openIndex: -1
    property bool hovered: hovered

    function activateTile(index, fromClick) {
        // CLICK → toggle
        if (fromClick) {
            if (openIndex === index)
                openIndex = -1
            else
                openIndex = index
            return
        }

        // HOVER → always open / switch
        if (openIndex === -1 || openIndex !== index)
            openIndex = index
    }

    Row {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 8
        spacing: 6

        HeaderTile {
            tileIndex: 0
            title: "File"
            model: fileModel
            open: header.openIndex === tileIndex
            headerHovered: header.hovered

            onHovered: header.activateTile(tileIndex, false)
            onClicked: header.activateTile(tileIndex, true)

            onOptionTriggered: function(optionId) {
                console.log("option file triggered")
                header.openIndex = -1
                header.menuAction(optionId)
            }
        }

        HeaderTile {
            tileIndex: 1
            title: "Edit"
            model: editModel
            open: header.openIndex === tileIndex
            headerHovered: header.hovered

            onHovered: header.activateTile(tileIndex, false)
            onClicked: header.activateTile(tileIndex, true)

            onOptionTriggered: function(optionId) {
                header.openIndex = -1
                header.menuAction(optionId)
            }
        }

        HeaderTile {
            tileIndex: 2
            title: "View"
            model: viewModel
            open: header.openIndex === tileIndex
            headerHovered: header.hovered

            onHovered: header.activateTile(tileIndex, false)
            onClicked: header.activateTile(tileIndex, true)

            onOptionTriggered: function(optionId) {
                header.openIndex = -1
                header.menuAction(optionId)
            }
        }

        HeaderTile {
            tileIndex: 3
            title: "Track"
            model: trackModel
            open: header.openIndex === tileIndex
            headerHovered: header.hovered

            onHovered: header.activateTile(tileIndex, false)
            onClicked: header.activateTile(tileIndex, true)

            onOptionTriggered: function(optionId) {
                header.openIndex = -1
                header.menuAction(optionId)
            }
        }

        HeaderTile {
            tileIndex: 4
            title: "Mixer"
            model: mixerModel
            open: header.openIndex === tileIndex
            headerHovered: header.hovered

            onHovered: header.activateTile(tileIndex, false)
            onClicked: header.activateTile(tileIndex, true)

            onOptionTriggered: function(optionId) {
                header.openIndex = -1
                header.menuAction(optionId)
            }
        }

        HeaderTile {
            tileIndex: 5
            title: "Help"
            model: helpModel
            open: header.openIndex === tileIndex
            headerHovered: header.hovered

            onHovered: header.activateTile(tileIndex, false)
            onClicked: header.activateTile(tileIndex, true)

            onOptionTriggered: function(optionId) {
                header.openIndex = -1
                header.menuAction(optionId)
            }
        }
    }

    ListModel {
        id: fileModel
        ListElement { actionId: "new_project";   label: "New Project" }
        ListElement { actionId: "open_project";  label: "Open…" }
        ListElement { actionId: "close_project"; label: "Close" }
        ListElement { actionId: "save";          label: "Save" }
        ListElement { actionId: "export";        label: "Export Audio" }
    }

    ListModel {
        id: editModel
        ListElement { actionId: "undo"; label: "Undo" }
        ListElement { actionId: "redo"; label: "Redo" }
    }

    ListModel {
        id: viewModel
        ListElement { actionId: "zoom_in"; label: "Zoom In" }
        ListElement { actionId: "zoom_out"; label: "Zoom Out" }
    }

    ListModel {
        id: trackModel
        ListElement { actionId: "add_audio_track";   label: "Add Audio Track" }
        ListElement { actionId: "add_midi_track";    label: "Add MIDI Track" }
        ListElement { actionId: "duplicate_track";   label: "Duplicate Track" }
        ListElement { actionId: "delete_track";      label: "Delete Track" }
        ListElement { actionId: "freeze_track";      label: "Freeze Track" }
    }

    ListModel {
        id: mixerModel
        ListElement { actionId: "add_bus";        label: "Add Bus Channel" }
        ListElement { actionId: "add_return";     label: "Add Return Track" }
        ListElement { actionId: "toggle_mixer";   label: "Show / Hide Mixer" }
        ListElement { actionId: "reset_levels";   label: "Reset All Levels" }
    }

    ListModel {
        id: helpModel
        ListElement { actionId: "show_shortcuts"; label: "Keyboard Shortcuts" }
        ListElement { actionId: "open_docs";      label: "Documentation" }
        ListElement { actionId: "about_app";      label: "About AudioMixer" }
    }
}
