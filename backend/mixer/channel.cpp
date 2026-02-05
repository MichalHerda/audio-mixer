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

float Channel::gain() const
{
    return m_gain;
}

void Channel::setGain(float gain)
{
    if (qFuzzyCompare(m_gain, gain))
        return;

    m_gain = gain;
    emit gainChanged();
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

ChannelState Channel::state() const
{
    return {
        m_name,
        m_volume,
        m_gain,
        m_pan,
        m_mute,
        m_solo,
        m_source
    };
}

void Channel::applyState(const ChannelState &s)
{
    setName(s.name);
    setVolume(s.volume);
    setGain(s.gain);
    setPan(s.pan);
    setMute(s.mute);
    setSolo(s.solo);
    setSource(s.source);
}
