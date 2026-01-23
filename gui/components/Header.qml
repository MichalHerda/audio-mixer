import QtQuick 2.15
import QtQuick.Layouts 1.15
import "../components"
import "../controls/header"
import AudioMixer

Rectangle {
    id: header
    color: Themes.backgroundColor
    border.color: Themes.borderColor
    border.width: 1

    signal menuAction(string actionId)

    Row {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 8
        spacing: 6

        HeaderTile {
            title: "File"
            model: ListModel {
                ListElement { actionId: "new_project";  label: "New Project" }
                ListElement { actionId: "open_project"; label: "Open…" }
                ListElement { actionId: "save";         label: "Save" }
                ListElement { actionId: "export";       label: "Export Audio" }
            }
            onOptionTriggered: header.menuAction(optionId)
        }

        HeaderTile {
            title: "Edit"
            model: ListModel {
                ListElement { actionId: "undo";              label: "Undo" }
                ListElement { actionId: "redo";              label: "Redo" }
                ListElement { actionId: "duplicate_channel"; label: "Duplicate Channel" }
                ListElement { actionId: "delete_channel";    label: "Delete Channel" }
            }
            onOptionTriggered: header.menuAction(optionId)
        }

        HeaderTile {
            title: "View"
            model: ListModel {
                ListElement { actionId: "show_mixer";   label: "Show Mixer" }
                ListElement { actionId: "show_routing"; label: "Show Routing" }
                ListElement { actionId: "zoom_in";      label: "Zoom In" }
                ListElement { actionId: "zoom_out";     label: "Zoom Out" }
            }
            onOptionTriggered: header.menuAction(optionId)
        }
    }
}
