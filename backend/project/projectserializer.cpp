#include "projectserializer.h"

ProjectSerializer::ProjectSerializer() {}

bool ProjectSerializer::save(const Project &project, const QString &path)
{
    QJsonObject root;
    root["version"] = 1;
    root["name"] = project.name;

    QJsonArray channels;
    for (const auto& ch : project.channels) {
        QJsonObject chObj;
        chObj["name"] = ch.name;
        chObj["volume"] = ch.volume;
        chObj["pan"] = ch.pan;
        chObj["mute"] = ch.mute;
        chObj["solo"] = ch.solo;
        chObj["source"] = ch.source;
        channels.append(chObj);
    }

    root["channels"] = channels;

    QJsonDocument doc(root);
    QFile file(path);

    if (!file.open(QIODevice::WriteOnly))
        return false;

    file.write(doc.toJson(QJsonDocument::Indented));
    return true;
}

bool ProjectSerializer::load(Project &project, const QString &path)
{
    QFile file(path);
    if (!file.open(QIODevice::ReadOnly))
        return false;

    QByteArray data = file.readAll();
    QJsonParseError parseError;
    QJsonDocument doc = QJsonDocument::fromJson(data, &parseError);

    if (parseError.error != QJsonParseError::NoError) {
        qWarning("Project JSON parse error: %s", qPrintable(parseError.errorString()));
        return false;
    }

    if (!doc.isObject())
        return false;

    QJsonObject root = doc.object();

    int version = root.value("version").toInt(1);
    Q_UNUSED(version);

    project.name = root.value("name").toString();

    project.channels.clear();
    QJsonArray channelsArray = root.value("channels").toArray();
    for (const auto& chVal : channelsArray) {
        if (!chVal.isObject())
            continue;

        QJsonObject chObj = chVal.toObject();
        ChannelState chState;
        chState.name   = chObj.value("name").toString();
        chState.volume = static_cast<float>(chObj.value("volume").toDouble());
        chState.pan    = static_cast<float>(chObj.value("pan").toDouble());
        chState.mute   = chObj.value("mute").toBool();
        chState.solo   = chObj.value("solo").toBool();
        chState.source = chObj.value("source").toString();

        project.channels.append(chState);
    }

    return true;
}

