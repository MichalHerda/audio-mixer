import QtQuick 2.15
import "../../controls"
import AudioMixer

Item {
    id: eq
    implicitHeight: 208
    implicitWidth: 64
    property int eqSectionSpacing: 8
    property color highColor: "yellow"
    property color midColor: "green"
    property color lowColor: "blue"

    property EQ eqModel

    Column {
        anchors.fill: parent
        spacing: 8

        Knob {
            label: "HIGH"
            from: -12
            to: 12
            value: eqModel ? eqModel.high : 0
            indicatorColor: highColor

            onSliderValueChanged: function(value) {
                if (eqModel) {
                    eqModel.high = value
                }
            }
        }

        Knob {
            label: "MID"
            from: -12
            to: 12
            value: eqModel ? eqModel.mid : 0
            indicatorColor: midColor

            onSliderValueChanged: function(value) {
                if (eqModel) {
                    eqModel.mid = value
                }
            }
        }

        Knob {
            label: "LOW"
            from: -12
            to: 12
            value: eqModel ? eqModel.low : 0
            indicatorColor: lowColor

            onSliderValueChanged: function(value) {
                if (eqModel) {
                    eqModel.low = value
                }
            }
        }
    }
}
