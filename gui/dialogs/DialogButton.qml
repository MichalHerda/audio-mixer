import QtQuick 2.15
import AudioMixer

Rectangle {
    id: root
    width: 120
    height: 36
    radius: 4

    property string text: ""
    property bool accent: false
    signal clicked()

    color: hovered
           ? (accent ? Themes.bghovered : Themes.bgHover)
           : Themes.bgMain

    border.color: accent
                  ? Themes.borderHover
                  : hovered
                    ? Themes.borderhovered
                    : Themes.borderIdle

    border.width: hovered ? 2 : 1

    Text {
        anchors.centerIn: parent
        text: root.text
        color: accent ? Themes.metalBright : Themes.metalMid
        font.pixelSize: 14
    }

    HoverHandler {
        id: hover
        onHoveredChanged: root.hovered = hovered
    }

    TapHandler {
        onTapped: root.clicked()
    }

    property bool hovered: false

    Behavior on color {
        ColorAnimation { duration: Themes.animFast }
    }

    Behavior on border.color {
        ColorAnimation { duration: Themes.animFast }
    }

    Behavior on border.width {
        NumberAnimation { duration: 120 }
    }
}
