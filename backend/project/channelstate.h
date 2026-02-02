#pragma once
#include <QString>

struct ChannelState {
    QString name;
    float volume;
    float pan;
    bool mute;
    bool solo;
    QString source;
};

