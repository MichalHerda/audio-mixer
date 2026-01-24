import QtQuick 2.15
import AudioMixer

Item {
    id: option
    implicitHeight: 26
    implicitWidth: 160

    property string text: ""
    property string optionId: ""

    signal triggered()
    property bool hovered: false

    Rectangle {
        anchors.fill: parent
        color: hovered ? Themes.bgHover : Themes.bgMain
        border.color: hovered
                      ? Qt.lighter(Themes.borderHover, 1.4)
                      : Themes.borderIdle
        border.width: hovered ? 2 : 1

        Behavior on color { ColorAnimation { duration: Themes.animFast } }
        Behavior on border.width { NumberAnimation { duration: 120 } }
    }

    Text {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10
        text: option.text
        color: "white"
        font.pixelSize: 11
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: option.hovered = true
        onExited: option.hovered = false
        onClicked: option.triggered()
    }
}
