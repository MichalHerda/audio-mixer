#include "appcontroller.h"

AppController::AppController(QObject *parent)
    : QObject(parent),
    m_mixerModel(new ChannelListModel(this))
{
    loadSettings();

    if (m_useMockupData) {
        loadMockupProject();
    }
}

ChannelListModel *AppController::mixerModel() const
{
     return m_mixerModel;
}

bool AppController::projectDirty() const
{
    return m_projectDirty;
}

void AppController::handleAction(const QString &actionId, int trackIndex)
{
    if (actionId == "close_project") {
        closeProject();
    }
    else if (actionId == "add_audio_track") {
        addAudioTrack(trackIndex);
    }
    else if (actionId == "delete_track") {
        if (trackIndex >= 0)
            deleteTrack(trackIndex);
    }
    else if (actionId == "open_project") {
        emit requestOpenProject();
    }
    else if (actionId == "save") {
        qDebug() << "requestSaveProject";
        emit requestSaveProject();
    }
    else if (actionId == "new_project") {
        emit requestNewProject();
    }
}

void AppController::newProject()
{
    m_mixerModel->clear();
    m_projectName = "Untitled";
    m_projectDirty = false;
    emit projectDirtyChanged();
}

bool AppController::openProject(const QString& path)
{
    QUrl url(path);
    QString localPath = url.isLocalFile() ? url.toLocalFile() : path;

    Project project;
    if (!ProjectSerializer::load(project, localPath))
        return false;

    m_mixerModel->clear();

    for (const auto& chState : project.channels) {
        Channel* ch = new Channel(m_mixerModel);
        ch->applyState(chState);
        m_mixerModel->addChannel(ch);
    }

    m_projectName = project.name;
    m_projectDirty = false;
    emit projectDirtyChanged();
    return true;
}

bool AppController::saveProject(const QString& path)
{
    QUrl url(path);
    QString localPath = url.isLocalFile() ? url.toLocalFile() : path;

    Project project;
    project.name = m_projectName;

    for (int i = 0; i < m_mixerModel->rowCount(); ++i) {
        project.channels.append(m_mixerModel->channelAt(i)->state());
    }

    if (!ProjectSerializer::save(project, localPath))
        return false;

    m_projectDirty = false;
    emit projectDirtyChanged();
    return true;
}

void AppController::addAudioTrack(int insertAfter)
{
    auto* channel = new Channel;

    channel->setName(QStringLiteral("Audio Track %1")
                         .arg(m_mixerModel->rowCount() + 1));

    int insertIndex =
        (insertAfter >= 0)
            ? insertAfter + 1
            : m_mixerModel->rowCount();

    m_mixerModel->addChannel(channel, insertIndex);
}

void AppController::deleteTrack(int index)
{
    if (index < 0)
        return;

    m_mixerModel->removeChannel(index);
}

void AppController::loadMockupProject()
{
    m_mixerModel->clear();

    auto add = [this](const QString& name) {
        auto* ch = new Channel(m_mixerModel);
        ch->setName(name);
        m_mixerModel->addChannel(ch);
    };

    add("Kick Drum           Mic 1");
    add("Snare Drum          Mic 2");
    add("Hi-Hat              Mic 3");
    add("Bass Guitar         DI");
    add("Electric Guitar L   Mic 4");
    add("Electric Guitar R,  Mic 5");
    add("Lead Vocal,         Mic 6");
    add("Backing Vocal,      Mic 7");
}

void AppController::closeProject()
{
    m_mixerModel->clear();

    m_useMockupData = false;
    saveSettings();

    emit mixerModelChanged();               // <--- TODO: should it be here?
}

void AppController::loadSettings()
{
    QSettings settings;
    m_useMockupData = settings.value("project/useMockupData", true).toBool();
}

void AppController::saveSettings()
{
    QSettings settings;
    settings.setValue("project/useMockupData", m_useMockupData);
}
