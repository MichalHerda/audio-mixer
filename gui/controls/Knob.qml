import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: knob
    implicitWidth: 64
    implicitHeight: 64

    /* ===== API ===== */
    property real from: 0.0
    property real to: 1.0
    property real value: slider.value
    property string label: ""
    property color knobColor: "black"
    property color borderColor: "grey"
    property color indicatorColor: "grey"
    property color labelColor: "grey"

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
        value: knob.from

        onValueChanged: knob.sliderValueChanged(value)
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

            /* body */
            Rectangle {
                id: knobBody
                anchors.centerIn: parent
                height: parent.height * 0.9
                width: parent.width * 0.9
                radius: width * 0.5
                color: knobColor
                border.color: borderColor
                border.width: 1

                /* indicator */
                Rectangle {
                    id: knobIndicator
                    anchors.horizontalCenter: knobBody.horizontalCenter
                    anchors.top: knobBody.top
                    height: knobBody.height * 0.45
                    width: knobBody.width * 0.1
                    //radius: 1
                    color: indicatorColor

                    transform: Rotation {
                        origin.x: knobIndicator.width * 0.5
                        origin.y: knobIndicator.height
                        angle: valueToAngle(slider.value)
                    }
                }
            }

            /* ===== INPUT ===== */
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.SizeVerCursor

                property real startValue

                onPressed: {
                    console.log("onPressed")
                    //startValue = slider.value
                }

                onPositionChanged: {
                    console.log("onPositionChanged")
                    /*
                    if (!pressed) return

                    let delta = -mouse.y + mouse.previousY
                    let sensitivity = (to - from) / 150

                    if (mouse.modifiers & Qt.ShiftModifier)
                        sensitivity *= 0.2   // fine control

                    slider.value = Math.min(
                        to,
                        Math.max(from, slider.value + delta * sensitivity)
                    )
                    */
                }

                onWheel: {
                    console.log("onWheel")
                    /*
                    let step = (to - from) / 100
                    slider.value += wheel.angleDelta.y > 0 ? step : -step
                    */
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
            color: labelColor
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
