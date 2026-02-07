import QtQuick 2.15
import QtQuick.Controls 2.15
import AudioMixer

Dialog {
    id: dialog
    parent: Overlay.overlay
    anchors.centerIn: parent
    modal: true
    focus: true

    width: 360
    height: 180

    property string action: ""

    background: Rectangle {
        radius: 6
        color: Themes.bgMain
        border.color: Themes.borderHover
        border.width: 2

        Behavior on border.color {
            ColorAnimation { duration: Themes.animFast }
        }
    }

    contentItem: Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        // TITLE
        Text {
            text: "Unsaved changes"
            font.pixelSize: 18
            font.bold: true
            color: Themes.metalBright
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }

        // MESSAGE
        Text {
            text: "Current project has unsaved changes.\nDo you want to continue without saving?"
            color: Themes.metalMid
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }

        // BUTTONS
        Row {
            spacing: 16
            anchors.horizontalCenter: parent.horizontalCenter

            DialogButton {
                text: "Cancel"
                accent: false
                onClicked: dialog.reject()
            }

            DialogButton {
                text: "Continue"
                accent: true
                onClicked: dialog.accept()
            }
        }
    }

    function openFor(a) {
        action = a
        open()
    }

    onAccepted: {
        console.log("ConfirmDialog accepted for action:", action)
        if (action === "close") {
            appController.discardChanges()
            appController.closeProject()
        } else {
            appController.discardChanges()
        }
    }

    onRejected: {
        console.log("ConfirmDialog canceled")
    }
}
