#ifndef CHANNELLISTMODEL_H
#define CHANNELLISTMODEL_H

#include <QAbstractListModel>
#include <QVariant>
#include <QHash>

class Channel;

class ChannelListModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum ChannelRoles {
        ChannelRole = Qt::UserRole + 1
    };
    Q_ENUM(ChannelRoles)

    explicit ChannelListModel(QObject *parent = nullptr);
    ~ChannelListModel() override;

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    Channel* channelAt(int index) const;
    void addChannel(Channel* channel);
    void removeChannel(int index);
    void clear();

private:
    QList<Channel*> m_channels;
};

#endif // CHANNELLISTMODEL_H
