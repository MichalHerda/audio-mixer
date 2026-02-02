#include "channellistmodel.h"
#include "channel.h"

ChannelListModel::ChannelListModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

ChannelListModel::~ChannelListModel()
{
    qDeleteAll(m_channels);
    m_channels.clear();
}

int ChannelListModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_channels.count();
}

QVariant ChannelListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    if (index.row() < 0 || index.row() >= m_channels.size())
        return QVariant();

    Channel *channel = m_channels.at(index.row());

    switch (role) {
    case ChannelRole:
        return QVariant::fromValue(channel);
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> ChannelListModel::roleNames() const
{
    return {
        { ChannelRole, "channel" }
    };
}

Channel *ChannelListModel::channelAt(int index) const
{
    if (index < 0 || index >= m_channels.size())
        return nullptr;

    return m_channels.at(index);
}

void ChannelListModel::addChannel(Channel *channel)
{
    addChannel(channel, m_channels.size());
}

void ChannelListModel::addChannel(Channel *channel, int index)
{
    if (!channel)
        return;

    channel->setParent(this);

    if (index < 0 || index > m_channels.size())
        index = m_channels.size();

    beginInsertRows(QModelIndex(), index, index);
    m_channels.insert(index, channel);
    endInsertRows();
}


void ChannelListModel::removeChannel(int index)
{
    if (index < 0 || index >= m_channels.size())
        return;

    beginRemoveRows(QModelIndex(), index, index);
    delete m_channels.takeAt(index);
    endRemoveRows();
}

void ChannelListModel::clear()
{
    beginResetModel();
    qDeleteAll(m_channels);
    m_channels.clear();
    endResetModel();
}
