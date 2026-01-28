#include "appcontroller.h"

AppController::AppController(QObject *parent)
    : QObject{parent}
{}

ChannelListModel *AppController::mixerModel() const
{
     return m_mixerModel;
}

void AppController::addAudioTrack()
{
    auto *channel = new Channel;

    channel->setName(
        QStringLiteral("Audio Track %1")
            .arg(m_mixerModel->rowCount())
        );

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
