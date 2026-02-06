#pragma once
#include <QObject>

class EQ : public QObject {

    Q_OBJECT
    Q_PROPERTY(float low READ low WRITE setLow NOTIFY lowChanged)
    Q_PROPERTY(float mid READ mid WRITE setMid NOTIFY midChanged)
    Q_PROPERTY(float high READ high WRITE setHigh NOTIFY highChanged)

public:
    EQ(QObject* parent = nullptr);

    float low() const;
    void setLow(float low);

    float mid() const;
    void setMid(float mid);

    float high() const;
    void setHigh(float high);

signals:
    void lowChanged();
    void midChanged();
    void highChanged();

private:
    float m_low = 0.0f;
    float m_mid = 0.0f;
    float m_high = 0.0f;
};
