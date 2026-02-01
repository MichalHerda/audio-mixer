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

void AppController::handleMenuAction(const QString &actionId)
{
    if (actionId == "close_project") {
        closeProject();
    }
}

void AppController::addAudioTrack()
{
    auto *channel = new Channel;

    channel->setName(QStringLiteral("Audio Track %1").arg(m_mixerModel->rowCount()));

    channel->setVolume(1.0f);
    channel->setPan(0.0f);
    channel->setMute(false);
    channel->setSolo(false);
    channel->setSource(QString());

    m_mixerModel->addChannel(channel);
}

void AppController::deleteTrack(int index)
{
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

    emit mixerModelChanged();
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
