import QtQuick 2.15
import QtQuick.Controls 2.15

Dialog {
    id: dialog
    modal: true
    focus: true

    width: 360
    height: 160

    property string action: ""

    title: "Unsaved changes"

    standardButtons: Dialog.Ok | Dialog.Cancel

    contentItem: Column {
        spacing: 12
        padding: 16

        Text {
            text: "Current project has unsaved changes.\nDo you want to continue without saving?"
            wrapMode: Text.WordWrap
        }
    }

    function openFor(a) {
        action = a
        open()
    }

    onAccepted: {
        console.log("ConfirmDialog accepted for action:", action)

    }

    onRejected: {
        console.log("ConfirmDialog canceled")
    }
}
