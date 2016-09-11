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

import QtQuick 2.2
import Sailfish.Silica 1.0
import harbour.hammerhead.torch 0.1

Dialog {
    property string name

    Column {
        width: parent.width

        DialogHeader {
            title: "Is the torch on?"
            acceptText: "YES"
            cancelText: "NO"
        }

        Label {
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Theme.fontSizeMedium
            color: Theme.primaryColor
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            text: qsTr("If the torch is on, then the new QtMultimedia implementation works on your device - click YES to use it instead of the old controlfile method. If the torch is not on, click NO to use the controlfile method.")
        }
    }

    onDone: {
        if (result == DialogResult.Accepted) {
            led.setUseControlFile(false)
            led.setTechnologyDialogCompleted()
        } else if (result == DialogResult.Rejected) {
            led.setUseControlFile(true)
            led.setTechnologyDialogCompleted()
        }

        // if the torch isn't on, turn it on
        led.on = true
    }
}
