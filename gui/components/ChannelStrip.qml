import QtQuick 2.15
import QtQuick.Layouts

import "../sections"
import "../controls"

Item {
    id: channel

    Rectangle {
        anchors.fill: parent
        color: "#1e1e1e"
        border.color: "#444"
        border.width: 1
    }

    ColumnLayout {
        id: channelColumn
        Layout.alignment: Qt.AlignHCenter
        Layout.margins: 8
        spacing: 2

        Knob {
            id: gainKnob
            label: "GAIN"
            from: 20
            to: 20000
            value: 1000
        }

        EQSection {
            id: eqSection
        }

        //VolumeFader {
        //    id: volumeFader
        //}
    }
}
