TARGET = harbour-hammerhead-torch

CONFIG += sailfishapp

# add configuration file to the package. If the configuration file is in a subdir, it doesn't get detected
configuration.files = controlfile.conf
#configuration.path = /etc/$${TARGET}
configuration.path = /usr/share/$${TARGET}
INSTALLS += configuration

SOURCES += src/harbour-hammerhead-torch.cpp \
    src/ledcontrol.cpp

HEADERS += \
    src/ledcontrol.h

OTHER_FILES += qml/harbour-hammerhead-torch.qml \
    qml/cover/CoverPage.qml \
    qml/pages/MainPage.qml \
    qml/pages/AboutPage.qml \
    qml/pages/SettingsPage.qml \
    qml/pages/ChooseTechnologyDialog.qml \
    rpm/harbour-hammerhead-torch.changes.in \
    rpm/harbour-hammerhead-torch.spec \
    rpm/harbour-hammerhead-torch.yaml \
    rpm/harbour-hammerhead-torch.changes \
    translations/*.ts \
    harbour-hammerhead-torch.desktop \
    controlfile.conf \
    brightness.conf

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

# to disable building translations every time, comment out the following CONFIG line
#CONFIG += sailfishapp_i18n
#TRANSLATIONS +=

RESOURCES += harbour-hammerhead-torch.qrc
