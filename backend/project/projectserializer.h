#ifndef PROJECTSERIALIZER_H
#define PROJECTSERIALIZER_H

#include <QFile>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonDocument>

#include "project.h"

class ProjectSerializer
{
public:
    ProjectSerializer();
public:
    static bool save(const Project& project, const QString& path);
    static bool load(Project& project, const QString& path);
};

#endif // PROJECTSERIALIZER_H
