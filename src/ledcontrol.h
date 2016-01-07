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
    Q_PROPERTY(bool on READ isOn WRITE setOnBool NOTIFY isOnBoolChanged);

    // path to the control file
    Q_PROPERTY(QString controlFile READ getPath WRITE setPath NOTIFY controlFilePathChanged);

public slots:
    // methods for reading/writing flashlight state
    bool isOn();
    Q_INVOKABLE bool toggleState();
    void setOnBool(bool);

    // methods for reading/writing control file path
    QString getPath();
    Q_INVOKABLE void setPath(QString fp);
    Q_INVOKABLE void detectPath();

signals:
    void isOnBoolChanged(bool);
    void controlFilePathChanged(QString);

private:
    bool checkFile();

    QFile file;
    bool m_isOn;
    QString controlFilePath;
    QSettings *settings;
};

#endif // LED_CONTROL_H
