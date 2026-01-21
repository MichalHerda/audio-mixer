import QtQuick 2.15
import QtQuick.Shapes 1.10

Item {
    id: root
    implicitWidth: 64
    implicitHeight: 32
    property color buttonColor: "black"
    property color buttonColorBorder: "grey"
    property color buttonColorBorderPressed: "green"
    property color buttonColorBorderHighlighted: "#6fb6ff"
    property color lightColorOn: "lightGreen"
    property color lightColorOff: "#1e1e1e"
    property color lightColorBorder: "grey"
    property color textColor: pressing ? "#ffffff" : "grey"
    property string buttonText: "SOLO"
    property int minTextWidth: implicitWidth * 0.75
    property bool compactLabel: buttonTxt.width < minTextWidth
    property real highlightPhase: 0.0
    property bool isOn: true
    property bool pressing: false
    property bool highlighted: buttonMouseArea.containsMouse

    signal mixerButtonClicked()

    Rectangle {
        id: mixerButton
        anchors.fill: parent
        radius: 60
        color: buttonColor
        border.color: {
            if (highlighted)
                return buttonColorBorderHighlighted
            return isOn ? buttonColorBorderPressed : buttonColorBorder
        }
        border.width: highlighted ? 2 : 1

        Behavior on border.color {
            ColorAnimation { duration: 200 }
        }

        Behavior on border.width {
            NumberAnimation { duration: 150 }
        }

        Rectangle {
            id: buttonLight
            width: parent.width * 0.2
            height: parent.height * 0.2
            anchors.horizontalCenter: parent.horizontalCenter
            color: isOn ? lightColorOn : lightColorOff
            radius: 180
            y: parent.height * 0.125
            border {
                color: lightColorBorder
                width: 1
            }
        }

        Rectangle {
            id: buttonGlow
            anchors.fill: parent
            radius: parent.radius
            visible: highlighted
            opacity: highlightPhase
            z: 1

            gradient: RadialGradient {
                centerX: 0.4
                centerY: 0.3
                GradientStop { position: 0.0; color: "#ffffff" }
                GradientStop { position: 0.4; color: "#cfd6dc" }
                GradientStop { position: 0.7; color: "#8f9aa3" }
                GradientStop { position: 1.0; color: "transparent" }
            }
        }


        Text {
            id: buttonTxt
            width: mixerButton.width * 0.8
            height:  mixerButton.height * 0.5
            visible: text.length < 6

            y: mixerButton.height * 0.425
            x: compactLabel ? mixerButton.width * 0.35 : mixerButton.width * 0.175

            text: { if (compactLabel)
                    return buttonText.length > 0 ? buttonText[0] : ""
                    return buttonText
            }

            color: textColor
            clip: true

            opacity: highlighted ? (0.6 + highlightPhase * 0.4) : 0.6

            Behavior on opacity {
                NumberAnimation { duration: 120 }
            }
    }

        MouseArea {
            id: buttonMouseArea
            anchors.fill: mixerButton
            hoverEnabled: true

            onClicked: {
                isOn = !isOn
                mixerButtonClicked()
            }
            onPressed: {
                mixerButton.scale = 0.9
                pressing = true
            }

            onReleased: {
                mixerButton.scale = 1.0
                mixerButtonClicked()
                pressing = false
            }

            onCanceled: {
                mixerButton.scale = 1.0
            }
        }

        Behavior on scale {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutQuad
            }
        }
    }

    SequentialAnimation on highlightPhase {
        running: highlighted
        loops: Animation.Infinite

        NumberAnimation {
            from: 0.25
            to: 0.55
            duration: pressing ? 250 : 500
            easing.type: Easing.InOutSine
        }
        NumberAnimation {
            from: 0.55
            to: 0.25
            duration: pressing ? 250 : 500
            easing.type: Easing.InOutSine
        }
    }


}
