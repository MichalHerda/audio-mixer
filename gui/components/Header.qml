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
    property int openIndex: -1

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

            onHovered: header.openIndex = tileIndex

            onClicked: header.openIndex = tileIndex
            function handleOption(id) {
                header.openIndex = -1
                header.menuAction(id)
            }
        }

        HeaderTile {
            tileIndex: 1
            title: "Edit"
            model: editModel
            open: header.openIndex === tileIndex

            onHovered: header.openIndex = tileIndex

            onClicked: header.openIndex = tileIndex
            function handleOption(id) {
                header.openIndex = -1
                header.menuAction(id)
            }
        }

        HeaderTile {
            tileIndex: 2
            title: "View"
            model: viewModel
            open: header.openIndex === tileIndex

            onHovered: header.openIndex = tileIndex

            onClicked: header.openIndex = tileIndex
            function handleOption(id) {
                header.openIndex = -1
                header.menuAction(id)
            }
        }
    }

    ListModel {
        id: fileModel
        ListElement { actionId: "new_project";  label: "New Project" }
        ListElement { actionId: "open_project"; label: "Open…" }
        ListElement { actionId: "save";         label: "Save" }
        ListElement { actionId: "export";       label: "Export Audio" }
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
}
