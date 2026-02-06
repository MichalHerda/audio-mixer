#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "./backend/app/appcontroller.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QCoreApplication::setOrganizationName("MichalHerda");
    QCoreApplication::setApplicationName("AudioMixer");

    qmlRegisterUncreatableType<Channel>(
        "AudioMixer",
        1, 0,
        "Channel",
        "Channel is a backend-only type"
    );
    qmlRegisterUncreatableType<EQ>(
        "AudioMixer",
        1, 0,
        "EQ",
        "EQ is a backend-only type"
    );

    QQmlApplicationEngine engine;

    AppController appController;
    engine.rootContext()->setContextProperty("appController", &appController);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("AudioMixer", "Main");

    return app.exec();
}
