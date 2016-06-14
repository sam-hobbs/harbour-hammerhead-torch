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

#include <QObject>
#include <QFile>
#include <QTextStream>
#include <QString>
#include <QDebug>
#include <QSettings>
#include <QVariant>
#include <QStandardPaths>

#include "ledcontrol.h"
#include "sailfishapp.h"

LEDControl::LEDControl() {
    // initialise settings object
    //settings = new QSettings("Feathers_McGraw","harbour-hammerhead-torch");
    settings = new QSettings(); // application name defaults to binary name

    // set the path of the control file that turns the flashlight on / off
    QString filePath;

    // on hammerhead the control file is /sys/class/leds/led\:flash_torch/brightness
    // on Jolla phone it is /sys/kernel/debug/flash_adp1650/mode
    // check for path stored in app settings

    if( settings->contains("controlFilePath") && settings->contains("device") )
    {
        setPath( settings->value( "controlFilePath", QString("") ).toString() );
        setDevice( settings->value( "device", QString("") ).toString() );
    }
    else
    {
        // try autodetecting
        detectPath();
    }

    // get initial file state
    m_isOn = checkFile();

    // if light is not on, turn it on
    if (!m_isOn) {
        toggleState();
    }

    qDebug() << "end of constructor";
}

LEDControl::~LEDControl() {
    // turn the torch off when closing the app
    if( isOn() )
        toggleState();
}

QString LEDControl::getDevice()
{
    return m_device;
}

void LEDControl::setDevice(QString name)
{
    qDebug() << "Storing device name " << name;
    m_device = name;
    emit deviceChanged(m_device);

    // store the new device name in settings
    settings->setValue("device",m_device);
}

void LEDControl::detectPath()
{
    qDebug() << "detectPath called";

    // get the name of this hardware from the /etc/hw-release file
    QSettings hwFile("/etc/hw-release", QSettings::IniFormat);
    QString name = hwFile.value("NAME").toString();
    qDebug() << "Name detected from /etc/hw-release is: " << name;

    // Use the name from /etc/hw-release to look up the control file location in controlfile.conf
    QSettings controlFileSettings("/usr/share/harbour-hammerhead-torch/controlfile.conf",QSettings::IniFormat);

    // Difficult to replace /usr/share/ with a variable, because QStandardPaths doesn't support an option that resolves to /usr/share/<APPNAME> yet
    //qDebug() << QStandardPaths::writableLocation(QStandardPaths::GenericDataLocation); //QStandardPaths::AppDataLocation and QStandardPaths::AppLocalDataLocation added in Qt 5.4

    if ( controlFileSettings.contains(name) ) {
        setDevice( name );
        setPath( controlFileSettings.value(name).toString() );
    } else {
        qDebug() << "Hardware not recognised";
        setDevice("Unknown");
        setPath("$HOME/hammerhead-torch-test.txt");
    }

}


QString LEDControl::getPath()
{
    qDebug() << "getPath called, current value is " << controlFilePath;
    return controlFilePath;
}


void LEDControl::setPath(QString fp)
{
    qDebug() << "Storing filepath " << fp;

    if (fp == file.fileName())
    {
        qDebug() << "filepath has not changed, doing nothing";
        return;
    }

    if (fp.isEmpty())
    {
        qCritical() << "Filepath is empty, doing nothing";
        return;
    }

    // close the file
    file.close();

    // set the new filename
    controlFilePath = fp;
    emit controlFilePathChanged(controlFilePath);

    // change the file object path to the new path
    file.setFileName(fp);

    // store the new fp in settings
    settings->setValue("controlFilePath",fp);

}

bool LEDControl::checkFile()
{
    // if the file is not readable, open it read only
    if ( file.isOpen() )
        file.close();

    file.open(QFile::ReadOnly | QIODevice::Text);

    QTextStream textStream(&file);
    QString data = textStream.readAll();

    file.close();

    if (data.toInt() == 1)
        return true;
    return false;

}

bool LEDControl::toggleState()
{

    QString data;
    if ( m_isOn )
    {
        // turn off
        data = QString::number(0);
    }
    else
    {
        // turn on
        data = QString::number(1);
    }

    if ( !file.exists() )
    {
        qDebug() << "file does not exist";
        return 1;
    }

    QFile ledFile(file.fileName());

    if ( !ledFile.open(QFile::WriteOnly) )
    {
        qDebug() << "can not open file";
        return 1;
    }

    QTextStream stream(&ledFile);
    stream << data;
    stream.flush();
    QTextStream::Status status = stream.status();
    ledFile.close();

    // check that the write succeeded before changing the state of led boolean
    if ( status != QTextStream::Ok )
    {
        qDebug() << "error writing to file";
        return 1;
    }

    // toggle the boolean using the setOnBool method, which will emit a signal and change the qml property
    setOnBool(!m_isOn);

    return 0;
}

bool LEDControl::isOn()
{
    return m_isOn;
}

void LEDControl::setOnBool(bool onBool)
{
    m_isOn = onBool;
    emit isOnBoolChanged(m_isOn);
}
