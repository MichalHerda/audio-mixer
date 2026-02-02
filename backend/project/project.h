#pragma once

#include <QString>
#include <QList>
#include "channelstate.h"

struct Project {
    QString name;
    QList<ChannelState> channels;
};
