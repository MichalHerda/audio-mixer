# AudioMixer (Qt/QML)

AudioMixer is a work-in-progress audio mixer UI application built with Qt and QML. Originally created as a portfolio project to demonstrate UI skills, it is currently being extended with a minimal backend, including models and a controller, to prepare a foundation for more complex audio applications. 

The current implementation includes:
- `Channel` objects representing individual mixer tracks with basic properties (volume, pan, mute, solo, source).
- `ChannelListModel` to manage a dynamic list of channels.
- `AppController` serving as a single access point for QML to interact with the backend.

The architecture is designed to be easily extendable, laying the groundwork for future enhancements such as full DAW functionality, project saving/loading, and advanced audio routing.

> ⚠️ Note: This project is under active development.

