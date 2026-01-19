import QtQuick 2.15
import QtQuick.Layouts
import "../controls"

Item {
    id: eq
    implicitHeight: 84

    ColumnLayout {
        //anchors.fill: parent
        spacing: 24

        Knob {
            label: "HIGH"
            from: -12
            to: 12
            value: 0
        }

        Knob {
            label: "MID"
            from: 20
            to: 20000
            value: 1000
        }

        Knob {
            label: "LOW"
            from: 0.1
            to: 10
            value: 1
        }
    }
}
