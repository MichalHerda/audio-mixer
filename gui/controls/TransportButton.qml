import QtQuick 2.15

MixerButton {
    id: btn
    buttonLightColor: isOn ? "blue" : "#1e1e1e"
    property color buttonColorBorder: "grey"
    property color buttonColorBorderPressed: "blue"
    buttonBorderColor: {
        if (highlighted)
            return buttonColorBorderHighlighted
        return isOn ? buttonColorBorderPressed : buttonColorBorder
    }
    enum Mode { Toggle, Momentary }
    property int mode: TransportButton.Toggle

    onMixerButtonClicked: {
        if (mode === TransportButton.Momentary) {
            isOn = false
        }
        clicked()
    }

    signal clicked()
}
