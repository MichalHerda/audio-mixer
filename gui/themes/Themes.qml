pragma Singleton

import QtQuick 2.15
import QtQml

QtObject {
    id: themes

    readonly property color backgroundColor: "#1e1e1e"
    readonly property color borderColor: "#808080"

    // active pallette
    readonly property color bgMain: "#1e1e1e"
    readonly property color bgHover: "#233047"
    readonly property color bgSelected: "#2b3a55"

    readonly property color borderIdle: "#444"
    readonly property color borderHover: "#6fb6ff"
    readonly property color borderSelected: "#4da3ff"

    readonly property color metalBright: "#ffffff"
    readonly property color metalMid: "#cfd6dc"
    readonly property color metalDark: "#8f9aa3"

    readonly property int animFast: 250
    readonly property int animSlow: 500
}
