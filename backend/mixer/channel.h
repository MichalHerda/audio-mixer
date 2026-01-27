#ifndef CHANNEL_H
#define CHANNEL_H

#include <QObject>

class Channel : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(float volume READ volume WRITE setVolume NOTIFY volumeChanged)
    Q_PROPERTY(float pan READ pan WRITE setPan NOTIFY panChanged)

    Q_PROPERTY(bool mute READ mute WRITE setMute NOTIFY muteChanged)
    Q_PROPERTY(bool solo READ solo WRITE setSolo NOTIFY soloChanged)

    Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sourceChanged)

public:
    explicit Channel(QObject *parent = nullptr);

    QString name() const;
    void setName(const QString &name);

    float volume() const;
    void setVolume(float volume);

    float pan() const;
    void setPan(float pan);

    bool mute() const;
    void setMute(bool mute);

    bool solo() const;
    void setSolo(bool solo);

    QString source() const;
    void setSource(const QString &source);

private:
    QString m_name;
    float   m_volume = 1.0f;
    float   m_pan = 0.0f;
    bool    m_mute = false;
    bool    m_solo = false;
    QString m_source;


signals:
    void nameChanged();
    void volumeChanged();
    void panChanged();
    void muteChanged();
    void soloChanged();
    void sourceChanged();
};

#endif // CHANNEL_H
