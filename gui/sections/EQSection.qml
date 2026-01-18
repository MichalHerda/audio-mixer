import QtQuick 2.15
import "../controls"

Item {
    id: eq
    //width: 80
    //height: 200

    Column {
        anchors.centerIn: parent
        height: parent.height
        spacing: 12

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
