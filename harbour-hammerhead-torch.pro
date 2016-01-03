TARGET = harbour-hammerhead-torch

CONFIG += sailfishapp

SOURCES += src/harbour-hammerhead-torch.cpp

HEADERS += src/fileio.h

OTHER_FILES += qml/harbour-hammerhead-torch.qml \
    qml/cover/CoverPage.qml \
    qml/pages/MainPage.qml \
    qml/pages/AboutPage.qml \
    rpm/harbour-hammerhead-torch.changes.in \
    rpm/harbour-hammerhead-torch.spec \
    rpm/harbour-hammerhead-torch.yaml \
    translations/*.ts \
    harbour-hammerhead-torch.desktop

SAILFISHAPP_ICONS = 86x86

# to disable building translations every time, comment out the following CONFIG line
#CONFIG += sailfishapp_i18n
#TRANSLATIONS +=

RESOURCES += harbour-hammerhead-torch.qrc
