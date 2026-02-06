#pragma once
#include <QString>
#include "eqstate.h"

struct ChannelState {
    QString name;
    float volume;
    float gain;
    float pan;
    bool mute;
    bool solo;
    QString source;

    EQState eq;
};

