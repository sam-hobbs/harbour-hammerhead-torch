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

#include "sailfishapp.h"

class LEDControl : public QObject
{
    Q_OBJECT

public:
    //LEDControl(QString fp); // QML needs to be able to initialise the type without arguments, so can't have any arguments in constructor
    LEDControl();

public slots:
    Q_INVOKABLE void setPath(const QString fp);
    Q_INVOKABLE bool isOn();
    Q_INVOKABLE bool toggleState();

private:
    QFile file;
};

#endif // LED_CONTROL_H
