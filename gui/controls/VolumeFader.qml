import QtQuick 2.15
import QtQuick.Controls 2.15

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
                width:  trackArea.width * 0.25
                height: trackArea.height
                color: "#444"
                radius: 2
            }

            Rectangle {
                id: handle
                implicitWidth: 20
                implicitHeight: 20
                radius: 4
                color: "#708090"

                y: trackArea.height * (1 - (slider.value - from)/(to - from)) - height/2
                anchors.horizontalCenter: parent.horizontalCenter
            }

            MouseArea {
                height: trackArea.height
                width: trackArea.width * 5
                anchors.horizontalCenter: parent.horizontalCenter
                hoverEnabled: true
                preventStealing: true
                cursorShape: Qt.SizeVerCursor

                property real startValue

                onPressed: function(mouse) {
                    startValue = slider.value
                }

                onPositionChanged: function(mouse) {
                    if (!pressed) return
                    let newValue = to - (mouse.y / trackArea.height) * (to - from)
                    slider.value = Math.min(to, Math.max(from, newValue))
                }

                onWheel: function(wheel) {
                    let step = (to - from) / 100
                    slider.value += wheel.angleDelta.y > 0 ? step : -step
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
