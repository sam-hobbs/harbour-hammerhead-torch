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


#ifndef FILEIO_H
#define FILEIO_H

#include <QObject>
#include <QFile>
#include <QTextStream>

#include "sailfishapp.h"

class FileIO : public QObject
{
    Q_OBJECT

public slots:
    bool write(const QString& source, const QString& data)
    {
        // if the source is an empty string, error
        if (source.isEmpty())
            return false;

        // if the source can't be opened write only, error
        QFile file(source);
        if (!file.open(QFile::WriteOnly | QFile::Truncate))
            return false;

        // make a textstream of the file and write the new data to it
        QTextStream out(&file);
        out << data;
        file.close();
        return true;
    }

public:
    FileIO() {}
};

#endif // FILEIO_H
