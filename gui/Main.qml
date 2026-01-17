import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("Audio Mixer")

    SplitView {
        id: appLayout
        anchors.fill: parent
        orientation: Qt.Vertical

        Header {
            id: appHeader
            SplitView.preferredHeight: 60
            SplitView.minimumHeight: 40
            SplitView.maximumHeight: 80
        }

        Transport {
            id: appTransport
            SplitView.preferredHeight: 80
            SplitView.minimumHeight: 60
            SplitView.maximumHeight: 100
        }

        Mixer {
            id: appMixer
            SplitView.fillHeight: true
            SplitView.minimumHeight: 100
        }
    }
}
