import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import AudioMixer

import "./components"

Window {
    id: root
    width: 960
    height: 880
    minimumHeight: 600
    minimumWidth: 320
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
