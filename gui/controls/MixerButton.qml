import QtQuick 2.15

Item {
    id: root
    implicitWidth: 64
    implicitHeight: 32
    property color buttonColor: "black"
    property color buttonColorBorder: "grey"
    property color buttonColorBorderPressed: "green"
    property color lightColorOn: "lightGreen"
    property color lightColorOff: "black"
    property color lightColorBorder: "grey"
    property color textColor: "grey"
    property string buttonText: "SOLO"
    signal mixerButtonClicked()

    Rectangle {
        id: mixerButton
        anchors.fill: parent
        radius: 60
        color: buttonColor
        border {
            color: buttonColorBorder
            width: 2
        }

        Rectangle {
            id: buttonLight
            width: parent.width * 0.2
            height: parent.height * 0.2
            anchors.horizontalCenter: parent.horizontalCenter
            color: lightColorOn
            radius: 180
            y: parent.height * 0.125
            border {
                color: lightColorBorder
                width: 1
            }
        }

        Text {
            id: buttonTxt
            width: mixerButton.width * 0.8
            height:  mixerButton.height * 0.5
            visible: text.length < 6
            y: mixerButton.height * 0.425
            x: mixerButton.width * 0.175
            text: buttonText
            color: textColor
        }

        MouseArea {
            id: buttonMouseArea
            anchors.fill: mixerButton
            onClicked: {
                buttonLight.color = ( buttonLight.color === lightColorOn ) ? lightColorOff : lightColorOn
            }
            onPressed: {
                mixerButton.scale = 0.9
                mixerButton.border.color = buttonColorBorderPressed
            }

            onReleased: {
                mixerButton.scale = 1.0
                mixerButtonClicked()
                mixerButton.border.color = buttonColorBorder
            }

            onCanceled: {
                mixerButton.scale = 1.0
                mixerButton.border.color = buttonColorBorder
            }
        }

        Behavior on scale {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutQuad
            }
        }
    }
}
