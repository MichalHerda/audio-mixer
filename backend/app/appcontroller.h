#ifndef APPCONTROLLER_H
#define APPCONTROLLER_H

#include <QObject>
#include <QSettings>

#include "backend/mixer/channellistmodel.h"
#include "backend/mixer/channel.h"
#include "backend/project/projectserializer.h"

class AppController : public QObject
{
    Q_OBJECT

    Q_PROPERTY(ChannelListModel* mixerModel READ mixerModel NOTIFY mixerModelChanged)
    Q_PROPERTY(bool projectDirty READ projectDirty NOTIFY projectDirtyChanged)

public:
    explicit AppController(QObject *parent = nullptr);

    ChannelListModel* mixerModel() const;
    bool projectDirty() const;

public slots:
    void handleAction(const QString& actionId, int trackIndex = -1);

    void newProject();
    bool openProject(const QString& path);
    bool saveProject(const QString& path);

    void addAudioTrack(int index);
    void deleteTrack(int index);

private:
    void loadMockupProject();
    void closeProject();
    void loadSettings();
    void saveSettings();

    ChannelListModel* m_mixerModel = nullptr;
    bool m_projectDirty = false;
    bool m_useMockupData = true;
    QString m_projectName = "";

signals:
    void mixerModelChanged();
    void projectDirtyChanged();
    void requestOpenProject();
    void requestSaveProject();
    void requestNewProject();

};

#endif // APPCONTROLLER_H
