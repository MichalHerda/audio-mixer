import QtQuick 2.15
import AudioMixer
import QtQuick.Layouts

import "../sections/transportSection"
import "../controls"

Item {
    id: transport
    property alias state: transportState
    property bool hovered: false
    readonly property bool highlighted: hovered

    implicitHeight: 80
    implicitWidth: 400

    TransportState {
        id: transportState
    }

    Rectangle {
        id: background
        anchors.fill: parent

        color: highlighted
               ? Themes.bgHover
               : Themes.bgMain

        border.color: highlighted
                      ? Themes.borderHover
                      : Themes.borderIdle

        border.width: highlighted ? 2 : 1

        Behavior on color { ColorAnimation { duration: Themes.animFast } }
        Behavior on border.color { ColorAnimation { duration: Themes.animFast } }
        Behavior on border.width { NumberAnimation { duration: 120 }
    }

        RowLayout {
            Layout.preferredWidth: implicitWidth
            Layout.minimumWidth: implicitWidth
            Layout.alignment: Qt.AlignHCenter
            spacing: 12

            Item {
                id: leftSeparator
                Layout.preferredWidth: 160
            }

            TransportControls {
                state: transportState
                Layout.alignment: Qt.AlignVCenter
            }

            TransportDisplay {
                state: transportState
            }

            Item {
                id: rightSeparator
                Layout.preferredWidth: 160
                Layout.fillWidth: true
            }
        }
    }
}
