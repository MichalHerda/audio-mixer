#ifndef APPCONTROLLER_H
#define APPCONTROLLER_H

#include <QObject>

#include "backend/mixer/channellistmodel.h"
#include "backend/mixer/channel.h"

class AppController : public QObject
{
    Q_OBJECT

    Q_PROPERTY(ChannelListModel* mixerModel READ mixerModel CONSTANT)
    //Q_PROPERTY(bool projectDirty READ projectDirty NOTIFY projectDirtyChanged)

public:
    explicit AppController(QObject *parent = nullptr);

    ChannelListModel* mixerModel() const;

public slots:
    //void newProject();
    //void openProject(const QUrl&);
    //void saveProject();

    void addAudioTrack();
    void deleteTrack(int index);

private:
    ChannelListModel* m_mixerModel = nullptr;

signals:

};

#endif // APPCONTROLLER_H
