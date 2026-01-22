import QtQuick 2.15
import AudioMixer
import QtQuick.Layouts

import "../sections/transportSection"
import "../controls"

Item {
    id: transport
    property alias state: transportState

    TransportState {
        id: transportState
    }
    Rectangle {
        id: background
        anchors.fill: parent
        color: Themes.bgMain

        RowLayout {
            Layout.preferredWidth: implicitWidth
            Layout.minimumWidth: implicitWidth
            Layout.alignment: Qt.AlignHCenter
            //width: parent.width * 0.75
            //anchors.horizontalCenter: parent.horizontalCenter
            spacing: 12

            Item {
                id: leftSeparator
                Layout.preferredWidth: 160
            }

            TransportControls {
                state: transportState
                //anchors.verticalCenter: parent.verticalCenter
                Layout.alignment: Qt.AlignVCenter
            }

            TransportDisplay {
                //height: transport.height
                state: transportState
                //Layout.fillWidth: true
            }

            Item {
                id: rightSeparator
                Layout.preferredWidth: 160
                Layout.fillWidth: true
            }
        }
    }
}
