import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.10

Item {
    id: knob
    focus: true
    implicitWidth: 64
    implicitHeight: 64

    property real from: 0.0
    property real to: 1.0
    property real value: from
    property string label: ""
    property color knobColor: "black"
    property color borderColor: "grey"
    property color indicatorColor: "grey"
    property color labelColor: "grey"
    property bool isDraggingNow: false
    readonly property bool highlighted:  knobMouseArea.containsMouse || knob.isDraggingNow
    property bool shine: true
    property real highlightPhase: 0.0

    signal sliderValueChanged(real value)

    // knob range
    readonly property real minAngle: -135
    readonly property real maxAngle: 135

    function valueToAngle(v) {
        return minAngle + (v - from) / (to - from) * (maxAngle - minAngle)
    }

    /* ===== MODEL ===== */
    Slider {
        id: slider
        anchors.fill: parent
        visible: false
        from: knob.from
        to: knob.to
        value: knob.value
        onValueChanged: {
            if (!isDraggingNow) {
                knob.value = slider.value
            }
            knob.sliderValueChanged(slider.value)
        }
    }



    /* ===== VISUAL ===== */
    Column {
        anchors.fill: parent
        spacing: parent.height * 0.1

        Item {
            id: knobArea
            height: parent.height * 0.6
            width: parent.height * 0.6
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                id: knobBody
                anchors.centerIn: parent
                height: parent.height * 0.9
                width: parent.width * 0.9
                radius: width * 0.5
                clip: true

                color: knobColor
                border.color: highlighted ? "lightskyblue" : borderColor
                border.width: highlighted ? 2 : 1

                /* ===== GOLD GLOW ===== */
                Rectangle {
                    id: shinningGlow
                    anchors.fill: parent
                    radius: parent.radius
                    visible: highlighted
                    opacity: highlighted && shine ? highlightPhase : 0.0

                    gradient: RadialGradient {
                        centerX: 0.35
                        centerY: 0.35
                        GradientStop { position: 0.0; color: "#ffffff" }
                        GradientStop { position: 0.25; color: "#cfd6dc" }
                        GradientStop { position: 0.5; color: "#8f9aa3" }
                        GradientStop { position: 1.0; color: "transparent" }
                    }
                }

                /* ===== INDICATOR ===== */
                Rectangle {
                    id: knobIndicator
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    height: parent.height * 0.45
                    width: parent.width * 0.1
                    color: indicatorColor

                    transform: Rotation {
                        origin.x: knobIndicator.width * 0.5
                        origin.y: knobIndicator.height
                        angle: valueToAngle(slider.value)
                    }
                }

                Behavior on border.color {
                    ColorAnimation { duration: 200 }
                }

                Behavior on border.width {
                    NumberAnimation { duration: 150 }
                }
            }


            MouseArea {
                id: knobMouseArea
                anchors.fill: parent
                hoverEnabled: true
                preventStealing: true
                cursorShape: Qt.SizeVerCursor

                property real startValue
                property real lastY


                onPressed: function(mouse) {
                    knob.isDraggingNow = true
                    startValue = slider.value
                    lastY = mouse.y
                    knob.forceActiveFocus()
                }

                onPositionChanged: function(mouse) {
                    if (!isDraggingNow) return
                    let delta = lastY - mouse.y
                    lastY = mouse.y
                    let sensitivity = (to - from) / 150
                    if (mouse.modifiers & Qt.ShiftModifier)
                        sensitivity *= 0.2

                    slider.value = Math.min(to, Math.max(from, slider.value + delta * sensitivity))
                }

                onReleased: function(mouse) {
                    console.log("onReleased")
                    knob.isDraggingNow = false
                }

                onWheel: function(wheel) {
                    let step = (to - from) / 100
                    slider.value += wheel.angleDelta.y > 0 ? step : -step
                }
            }
        }

        Text {
            id: knobLabel
            height: parent.height * 0.3
            width: parent.width * 0.8
            anchors.horizontalCenter: parent.horizontalCenter
            visible: label.length > 0
            text: label
            font.pixelSize: 10
            horizontalAlignment: Text.AlignHCenter

            color: highlighted ? "#ffffff" : labelColor
            opacity: highlighted ? highlightPhase : 0.6

            Behavior on color {
                ColorAnimation { duration: 150 }
            }
        }

    }

// TODO:
// In your free time, you should create an ActiveItem component that will be the base for all controls .
// and will contain the variables: shine, highlightPhase, and SequentialAnimationion common to all components
// Previous attempts have resulted in problems with the coordinates.

    SequentialAnimation on highlightPhase {
        running: highlighted && shine
        loops: Animation.Infinite

        NumberAnimation {
            from: 0.25
            to: isDraggingNow ? 0.8 : 0.55
            duration: isDraggingNow ? 250 : 500
            easing.type: Easing.InOutSine
        }
        NumberAnimation {
            from: isDraggingNow ? 0.8 : 0.55
            to: 0.25
            duration: isDraggingNow ? 250 : 500
            easing.type: Easing.InOutSine
        }
    }
}
