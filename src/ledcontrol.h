/*

Hammerhead Torch

Copyright (C) 2015 Sam Hobbs

This file is part of Hammerhead Torch.

Hammerhead Torch is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Hammerhead Torch is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Hammerhead Torch.  If not, see <http://www.gnu.org/licenses/>

*/


#ifndef LED_CONTROL_H
#define LED_CONTROL_H

#include <QObject>
#include <QFile>
#include <QTextStream>
#include <QString>
#include <QSettings>
#include <QVariant>

#include "sailfishapp.h"

class LEDControl : public QObject
{
    Q_OBJECT

public:
    LEDControl(); // can't have any arguments in constructor, because QML needs to be able to initialise it
    ~LEDControl();

    // property for allowing QML to read/write/track whether the flashlight is on
    Q_PROPERTY(bool on READ isOn WRITE setOnBool NOTIFY isOnBoolChanged)

    // property for checking for a valid path from QML
    Q_PROPERTY(bool validPath READ isValidPath NOTIFY isValidPathChanged)

    // path to the control file
    Q_PROPERTY(QString controlFile READ getPath WRITE setPath NOTIFY controlFilePathChanged)

    // detected device name
    Q_PROPERTY(QString device READ getDevice WRITE setDevice NOTIFY deviceChanged)

    // brightness to write to file
    Q_PROPERTY(QString brightness READ getBrightness WRITE setBrightness NOTIFY brightnessChanged)

    // determine whether to use qtmultimedia or fallback control file method
    Q_PROPERTY(bool useControlFile READ getUseControlFile WRITE setUseControlFile NOTIFY useControlFileChanged)

    // has the user completed the dialog asking if the qtmultimedia method works?
    Q_PROPERTY(bool technologyDialogCompleted READ getTechnologyDialogCompleted)

    // property for tracking whether the light is on using the qtmultimedia method
    Q_PROPERTY(bool qtMultimediaOn READ isQtMultimediaOn WRITE setQtMultimediaOn NOTIFY qtMultimediaOnChanged)

public slots:
    // methods for reading/writing flashlight state
    Q_INVOKABLE bool isOn();
    Q_INVOKABLE bool toggleState();
    void setOnBool(bool);

    // methods reading valid path
    bool isValidPath();

    // methods for reading and detecting control file path
    Q_INVOKABLE QString getPath();
    Q_INVOKABLE void detectPath();

    // method for reading detected device name
    Q_INVOKABLE QString getDevice();

    // method for reading brightness
    Q_INVOKABLE QString getBrightness();


    // methods for reading and writing whether to use qtmultimedia method
    Q_INVOKABLE bool getUseControlFile();
    Q_INVOKABLE void setUseControlFile(bool);

    Q_INVOKABLE bool getTechnologyDialogCompleted();
    Q_INVOKABLE void setTechnologyDialogCompleted();

    bool isQtMultimediaOn();
    void setQtMultimediaOn(bool);

signals:
    void isOnBoolChanged(bool);
    void controlFilePathChanged(QString);
    void deviceChanged(QString);
    void isValidPathChanged(bool);
    void brightnessChanged(QString);

    void useControlFileChanged(bool);
    void technologyDialogCompletedChanged(bool);

    void qtMultimediaOnChanged(bool);

private:
    bool checkFile();
    void setPath(QString fp);
    void setDevice(QString name);
    void setBrightness(QString brightness);

    QFile file;
    bool m_isOn;
    bool m_qtMultimediaOn;
    bool m_isValid;
    QString controlFilePath;
    QSettings *applicationSettings;
    QString m_device;
    QString m_brightness;

    bool m_useControlFile;
};

#endif // LED_CONTROL_H
