import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.10

Item {
    id: fader
    implicitWidth: 64
    implicitHeight: 224

    /* ===== API ===== */
    property real from: 0.0
    property real to: 1.0
    property real value: slider.value
    property string label: "VOL"

    property int volSectionSpacing: 12
    property bool isDraggingNow: false
    readonly property bool highlighted: trackMouseArea.containsMouse || isDraggingNow

    //signal valueChanged(real value)

    /* ===== MODEL ===== */
    Slider {
        id: slider
        anchors.fill: parent
        visible: false

        from: fader.from
        to: fader.to
        value: fader.from

        //onValueChanged: fader.valueChanged(value)
    }

    /* ===== VISUAL ===== */
    Column {
        id: volumeFaderColumn
        anchors.fill: parent
        spacing: volSectionSpacing

        Item {
            id: trackArea
            width: volumeFaderColumn.width * 0.3
            height: volumeFaderColumn.height * 0.75
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                id: track
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                width: trackArea.width * 0.25
                height: trackArea.height
                radius: 2
                clip: true

                color: "#444"

                Rectangle {
                    id: trackGlow
                    anchors.fill: parent
                    radius: parent.radius
                    visible: highlighted
                    opacity: 0.0

                    gradient: LinearGradient {
                        //orientation: Gradient.Vertical
                        GradientStop { position: 0.0; color: "#ffffff" }
                        GradientStop { position: 0.25; color: "#cfd6dc" }
                        GradientStop { position: 0.5; color: "#8f9aa3" }
                        GradientStop { position: 1.0; color: "transparent" }
                    }

                    SequentialAnimation on opacity {
                        running: highlighted
                        loops: Animation.Infinite

                        NumberAnimation {
                            from: 0.25
                            to: fader.isDraggingNow ? 0.8 : 0.55
                            duration: fader.isDraggingNow ? 250 : 500
                            easing.type: Easing.InOutSine
                        }
                        NumberAnimation {
                            from: fader.isDraggingNow ? 0.8 : 0.55
                            to: 0.25
                            duration: fader.isDraggingNow ? 250 : 500
                            easing.type: Easing.InOutSine
                        }
                    }
                }
            }

            Rectangle {
                id: handle
                implicitWidth: 20
                implicitHeight: 20
                radius: 4
                clip: true

                color: "#708090"
                border.color: highlighted ? "lightskyblue" : "#555"
                border.width: highlighted ? 2 : 1

                y: trackArea.height * (1 - (slider.value - from)/(to - from)) - height/2
                anchors.horizontalCenter: parent.horizontalCenter

                Rectangle {
                    id: handleGlow
                    anchors.fill: parent
                    radius: parent.radius
                    visible: highlighted
                    opacity: 0.0

                    gradient: RadialGradient {
                        centerX: 0.35
                        centerY: 0.35
                        GradientStop { position: 0.0; color: "#ffffff" }
                        GradientStop { position: 0.25; color: "#cfd6dc" }
                        GradientStop { position: 0.5; color: "#8f9aa3" }
                        GradientStop { position: 1.0; color: "transparent" }
                    }

                    SequentialAnimation on opacity {
                        running: highlighted
                        loops: Animation.Infinite

                        NumberAnimation {
                            from: 0.25
                            to: fader.isDraggingNow ? 0.8 : 0.55
                            duration: fader.isDraggingNow ? 250 : 500
                            easing.type: Easing.InOutSine
                        }
                        NumberAnimation {
                            from: fader.isDraggingNow ? 0.8 : 0.55
                            to: 0.25
                            duration: fader.isDraggingNow ? 250 : 500
                            easing.type: Easing.InOutSine
                        }
                    }
                }

                Behavior on border.color { ColorAnimation { duration: 200 } }
                Behavior on border.width { NumberAnimation { duration: 150 } }
            }

            MouseArea {
                id: trackMouseArea
                height: trackArea.height * 1.3
                width: trackArea.width * 5
                anchors.horizontalCenter: parent.horizontalCenter
                hoverEnabled: true
                preventStealing: true
                cursorShape: Qt.SizeVerCursor

                property real startValue

                onPressed: function(mouse) {
                    fader.isDraggingNow = true
                    startValue = slider.value
                }

                onReleased: {
                    fader.isDraggingNow = false
                }

                onPositionChanged: function(mouse) {
                    if (!pressed) return
                    let newValue = to - (mouse.y / trackArea.height) * (to - from)
                    slider.value = Math.min(to, Math.max(from, newValue))
                }

                onWheel: function(wheel) {
                    fader.isDraggingNow = true
                    let step = (to - from) / 100
                    slider.value += wheel.angleDelta.y > 0 ? step : -step
                    fader.isDraggingNow = false
                }
            }
        }

        /* Label */
        Text {
            text: label
            font.pixelSize: 10
            color: "#aaa"
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }
    }
}
