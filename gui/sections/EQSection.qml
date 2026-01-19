import QtQuick 2.15
import "../controls"

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
            //borderColor: highColor
            indicatorColor: highColor
            //labelColor: highColor
        }

        Knob {
            label: "MID"
            from: 20
            to: 20000
            value: 1000
            //borderColor: midColor
            indicatorColor: midColor
            //labelColor: midColor
        }

        Knob {
            label: "LOW"
            from: 0.1
            to: 10
            value: 1
            //borderColor: lowColor
            indicatorColor: lowColor
            //labelColor: lowColor
        }
    }
}
