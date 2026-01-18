import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: knob
    width: 64
    height: 80

    /* ===== API ===== */
    property real from: 0.0
    property real to: 1.0
    property real value: slider.value
    property string label: ""

    //signal valueChanged(real value)

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
        value: knob.from

        //onValueChanged: knob.valueChanged(value)
    }

    /* ===== VISUAL ===== */
    Column {
        anchors.centerIn: parent
        spacing: 6

        Item {
            id: knobArea
            width: 48
            height: 48

            /* body */
            Rectangle {
                anchors.fill: parent
                radius: width / 2
                color: "#2b2b2b"
                border.color: "#555"
                border.width: 1
            }

            /* indicator */
            Rectangle {
                width: 2
                height: parent.height / 2 - 6
                radius: 1
                color: "#e0e0e0"

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.verticalCenter

                transform: Rotation {
                    origin.x: 1
                    origin.y: parent.height
                    angle: valueToAngle(slider.value)
                }
            }

            /* ===== INPUT ===== */
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.SizeVerCursor

                property real startValue

                onPressed: {
                    startValue = slider.value
                }

                onPositionChanged: {
                    if (!pressed) return

                    let delta = -mouse.y + mouse.previousY
                    let sensitivity = (to - from) / 150

                    if (mouse.modifiers & Qt.ShiftModifier)
                        sensitivity *= 0.2   // fine control

                    slider.value = Math.min(
                        to,
                        Math.max(from, slider.value + delta * sensitivity)
                    )
                }

                onWheel: {
                    let step = (to - from) / 100
                    slider.value += wheel.angleDelta.y > 0 ? step : -step
                }
            }
        }

        /* label */
        Text {
            visible: label.length > 0
            text: label
            font.pixelSize: 10
            color: "#aaa"
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }
    }
}
