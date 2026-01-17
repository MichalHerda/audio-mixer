cmake_minimum_required(VERSION 3.21)

project(AudioMixer VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appAudioMixer
    main.cpp
)

# NO IDEA, WHY IT IS NOT POSSIBLE TO REGISTER THEME SINGLETON IN THIS PROJECT
# I HAVE TRIED ALSO QMLDIR APPROACH AND IT ALSO DOES NOT WORK
#
# list(APPEND QML_IMPORT_PATH gui/theme/Theme.qml)
# set(QML_IMPORT_PATH ${CMAKE_SOURCE_DIR}/qml ${CMAKE_BINARY_DIR}/imports CACHE STRING "" FORCE)

# set_source_files_properties(gui/theme/Theme.qml
#    PROPERTIES QT_QML_SINGLETON_TYPE TRUE)

qt_add_qml_module(appAudioMixer
    URI AudioMixer
    QML_FILES
        gui/Main.qml
        gui/controls/Knob.qml
        gui/controls/VolumeFader.qml
        gui/sections/EQSection.qml
        gui/components/Header.qml
        gui/components/Transport.qml
        gui/components/Mixer.qml
        gui/controls/InputSelector.qml
        gui/sections/MuteSoloRow.qml
        gui/sections/FxSendSection.qml
        gui/controls/MixerButton.qml
        gui/theme/Theme.qml
        RESOURCES gui/theme/qmldir
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appAudioMixer PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appAudioMixer
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appAudioMixer
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appAudioMixer
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
