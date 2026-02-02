#include "channel.h"

Channel::Channel(QObject *parent)
    : QObject{parent}
{}

QString Channel::name() const
{
    return m_name;
}

void Channel::setName(const QString &name)
{
    if (m_name == name)
        return;

    m_name = name;
    emit nameChanged();
}

float Channel::volume() const
{
    return m_volume;
}

void Channel::setVolume(float volume)
{
    if (qFuzzyCompare(m_volume, volume))
        return;

    m_volume = volume;
    emit volumeChanged();
}

float Channel::pan() const
{
    return m_pan;
}

void Channel::setPan(float pan)
{
    if (qFuzzyCompare(m_pan, pan))
        return;

    m_pan = pan;
    emit panChanged();
}

bool Channel::mute() const
{
    return m_mute;
}

void Channel::setMute(bool mute)
{
    if(mute == m_mute) return;

    m_mute = mute;
    emit muteChanged();
}

bool Channel::solo() const
{
    return m_solo;
}

void Channel::setSolo(bool solo)
{
    if(solo == m_solo) return;

    m_solo = solo;
    emit soloChanged();
}

QString Channel::source() const
{
    return m_source;
}

void Channel::setSource(const QString &source)
{
    if (m_source == source)
        return;

    m_source = source;
    emit sourceChanged();
}
