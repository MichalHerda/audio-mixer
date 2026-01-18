import QtQuick 2.15
import QtQuick.Layouts
import "../components"

Item {
    id: mixer

    RowLayout {
        id: channelsRow
        anchors.fill: parent
        anchors.margins: 5              //Math.min(mixer.width * 0.01, mixer.height * 0.01)
        spacing: 5                      //Math.min(mixer.width * 0.01, mixer.height * 0.01)
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
