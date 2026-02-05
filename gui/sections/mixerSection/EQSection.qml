import QtQuick 2.15
import "../../controls"

Item {
    id: eq
    implicitHeight: 208
    implicitWidth: 64
    property int eqSectionSpacing: 8
    property color highColor: "yellow"
    property color midColor: "green"
    property color lowColor: "blue"

    Column {
        anchors.fill: parent
        spacing: 8

        Knob {
            label: "HIGH"
            from: -12
            to: 12
            value: 0
            indicatorColor: highColor
        }

        Knob {
            label: "MID"
            from: -12
            to: 12
            value: 0
            indicatorColor: midColor
        }

        Knob {
            label: "LOW"
            from: -12
            to: 12
            value: 0
            indicatorColor: lowColor
        }
    }
}
