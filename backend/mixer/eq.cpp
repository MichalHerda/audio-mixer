#include "eq.h"

EQ::EQ(QObject* parent) {}

float EQ::low() const
{
    return m_low;
}

void EQ::setLow(float low)
{
    if (qFuzzyCompare(m_low, low))
        return;

    m_low = low;
    emit lowChanged();
}

float EQ::mid() const
{
    return m_mid;
}

void EQ::setMid(float mid)
{
    if (qFuzzyCompare(m_mid, mid))
        return;

    m_mid = mid;
    emit midChanged();
}

float EQ::high() const
{
    return m_high;
}

void EQ::setHigh(float high)
{
    if (qFuzzyCompare(m_high, high))
        return;

    m_high = high;
    emit highChanged();
}


