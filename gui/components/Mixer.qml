import QtQuick 2.15
import QtQuick.Layouts
import AudioMixer
import "../components"

Rectangle {
    id: mixer
    color: Themes.backgroundColor
    border {
        color: Themes.borderColor
        width: 1
    }

    RowLayout {
        id: channelsRow
        anchors.fill: parent
        //anchors.margins: 5
        spacing: 5
        Layout.alignment: Qt.AlignLeft
        Layout.fillWidth: false

        Repeater {
            model: 4                                                // mockup - for debugging UI
            ChannelStrip {
                Layout.preferredWidth: 120
                Layout.minimumWidth: 80
                Layout.maximumWidth: 200
                Layout.fillHeight: true
                Layout.fillWidth: false
            }
        }

        Item {
            id: separator
            Layout.fillWidth: true
        }
    }
}
