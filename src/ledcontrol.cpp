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

#include "ledcontrol.h"
#include "sailfishapp.h"

LEDControl::LEDControl() {
    // control file is here /sys/class/leds/led\:flash_torch/brightness
    setPath("/sys/class/leds/led:flash_torch/brightness");
}


void LEDControl::setPath(const QString fp)
{
    if (fp == file.fileName())
    {
        qDebug() << "setPath called but path has not changed, doing nothing";
        return;
    }

    if (fp.isEmpty())
    {
        qCritical() << "Filepath is empty";
        return;
    }

    // close the file
    file.close();

    // set the new filename
    file.setFileName(fp);

}

bool LEDControl::isOn()
{
    // if the file is not readable, open it read only
    if ( file.isOpen() )
        file.close();

    file.open(QFile::ReadOnly | QIODevice::Text);

    QTextStream textStream(&file);
    QString data = textStream.readAll();
    qDebug() << "file contains: " << data;
    //qDebug() << "data converted to int is: " << data.toInt();
    if (data.toInt() == 1)
        return true;
    return false;

    file.close();
}

bool LEDControl::toggleState()
{

    QString data;
    if ( isOn() )
    {
        // turn off
        data = QString::number(0);
    }
    else
    {
        // turn on
        data = QString::number(1);
    }

    // close and open again with different properties
    if ( file.isOpen() )
        file.close();

    // if the file can't be opened RW, error
    if ( !file.open(QFile::ReadWrite | QFile::Truncate | QIODevice::Text))
        return 1;

    qDebug() << "Data to be written is: " << data;

    // make a textstream of the file and write the new data to it
    QTextStream out(&file);
    out << data;
    file.close();
    return 0;
}
