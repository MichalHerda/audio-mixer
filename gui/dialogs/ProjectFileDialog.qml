import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt.labs.platform 1.1

Item {
    id: root

    property string mode: "open"                        // "open" | "save"

    signal fileSelected(string path)

    FileDialog {
        id: dialog

        title: mode === "open" ? "Open Project" : "Save Project"
        folder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)

        fileMode: mode === "open" ? FileDialog.OpenFile : FileDialog.SaveFile

        nameFilters: [ "AudioMixer Project (*.json)" ]
        defaultSuffix : "json"

        onAccepted: {
            console.log("ProjectFileDialog selected:", file)
            root.fileSelected(file)
        }

        onRejected: {
            console.log("ProjectFileDialog canceled")
        }
    }

    function openForOpen() {
        mode = "open"
        dialog.open()
    }

    function openForSave() {
        mode = "save"
        dialog.open()
    }
}
