#ifndef APPCONTROLLER_H
#define APPCONTROLLER_H

#include <QObject>
#include <QSettings>

#include "backend/mixer/channellistmodel.h"
#include "backend/mixer/channel.h"
#include "backend/mixer/eq.h"
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
    void closeProject();
    bool openProject(const QString& path);
    bool saveProject(const QString& path);

    void discardChanges();

    void addAudioTrack(int index);
    void deleteTrack(int index);

private:
    void loadMockupProject();
    void loadSettings();
    void saveSettings();
    void markProjectDirty();
    void registerChannel(Channel* channel);

    ChannelListModel* m_mixerModel = nullptr;
    bool m_projectDirty = false;
    bool m_useMockupData = true;
    bool m_loadingProject = false;

    QString m_projectName = "";

signals:
    void mixerModelChanged();
    void projectDirtyChanged();
    void requestOpenProject();
    void requestCloseProject();
    void requestSaveProject();
    void requestNewProject();

};

#endif // APPCONTROLLER_H
