import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: fader
    implicitWidth: 64
    implicitHeight: 208

    /* ===== API ===== */
    property real from: 0.0
    property real to: 1.0
    property real value: slider.value
    property string label: "VOL"

    property int volSectionSpacing: 8

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
        //anchors.margins: 4
        spacing: volSectionSpacing

        Item {
            id: trackArea
            width: volumeFaderColumn.width * 0.2
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
                implicitWidth: 16
                implicitHeight: 16
                radius: 4
                color: "#e0e0e0"

                y: trackArea.height * (1 - (slider.value - from)/(to - from)) - height/2
                anchors.horizontalCenter: parent.horizontalCenter
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.SizeVerCursor

                property real startValue

                onPressed: startValue = slider.value

                onPositionChanged: {
                    if (!pressed) return
                    let newValue = to - (mouse.y / trackArea.height) * (to - from)
                    slider.value = Math.min(to, Math.max(from, newValue))
                }

                onWheel: {
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
