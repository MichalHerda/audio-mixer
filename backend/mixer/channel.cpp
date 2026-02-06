#include "channel.h"

Channel::Channel(QObject *parent)
    : QObject{parent}, m_eq(new EQ(this))
{

}

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

EQ *Channel::eq() const
{
    return m_eq;
}

ChannelState Channel::state() const
{
    ChannelState s;
    s.name   = m_name;
    s.volume = m_volume;
    s.gain   = m_gain;
    s.pan    = m_pan;
    s.mute   = m_mute;
    s.solo   = m_solo;
    s.source = m_source;

    s.eq.low  = m_eq->low();
    s.eq.mid  = m_eq->mid();
    s.eq.high = m_eq->high();

    return s;
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

    m_eq->setLow(s.eq.low);
    m_eq->setMid(s.eq.mid);
    m_eq->setHigh(s.eq.high);
}
