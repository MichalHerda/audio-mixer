#pragma once
#include <QString>

struct ChannelState {
    QString name;
    float volume;
    float gain;
    float pan;
    bool mute;
    bool solo;
    QString source;
};

