import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import AudioMixer

import "./components"
import "./dialogs"

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
                appController.handleAction(id)
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

    ProjectFileDialog {
        id: projectFileDialog
    }

    ConfirmDialog {
        id: confirmDialog
    }

    Connections {
        target: appController

        function onRequestOpenProject() {
            if (appController.projectDirty) {
                confirmDialog.openFor("open")
            }
            else {
                projectFileDialog.openForOpen()
            }
        }

        function onRequestSaveProject() {
            projectFileDialog.openForSave()
        }

        function onRequestNewProject() {
            if (appController.projectDirty) {
                confirmDialog.openFor("new")
            }
            else {
                appController.newProject()
            }
        }
    }

    Connections {
        target: projectFileDialog

        function onFileSelected(path) {
            if (projectFileDialog.mode === "open") {
                console.log("OPEN:", path)
                appController.openProject(path)
            }
            else {
                console.log("SAVE:", path)
                appController.saveProject(path)
            }
        }
    }
}
