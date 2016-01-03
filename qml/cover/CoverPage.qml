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

import QtQuick 2.0
import Sailfish.Silica 1.0
import uk.co.samhobbs 0.1

Cover {
    id: cover

    transparent: true

    Image {
        id: coverIcon
        source: ( led.isOn() ) ? "qrc:///hammerhead-inverted" : "qrc:///hammerhead"

        fillMode: Image.PreserveAspectFit
        cache: true
        anchors.centerIn: parent
        width: parent.width
        x: Theme.paddingSmall
    }

    Label {
        id: label

        anchors.centerIn: parent
        anchors.verticalCenterOffset: -parent.height/3

        // text displayed on cover
        text: qsTr("Torch")
        font.pixelSize: Theme.fontSizeLarge
    }


    CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: "image://theme/icon-m-dot"

            onTriggered:
            {
                console.log("cover action clicked!")
                led.toggleState()
                coverIcon.source = ( led.isOn() ) ? "qrc:///hammerhead-inverted" : "qrc:///hammerhead"

            }

        }
    }
}
