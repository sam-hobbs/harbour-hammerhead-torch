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

Page {
    objectName: "SettingsPage"

    Column {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: Theme.paddingMedium
        anchors.rightMargin: Theme.paddingMedium
        PageHeader {
            title: qsTr("Settings")
        }
//        Item {
//            width: 1
//            height: Theme.paddingLarge
//        }
        Label {
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Theme.fontSizeMedium
            color: Theme.primaryColor
            text: qsTr("Detect or set control file path")
        }
        Item {
            width: 1
            height: Theme.paddingLarge
        }

        Label {
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Theme.fontSizeExtraSmall
            color: Theme.secondaryColor
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            text: "The control file is a file on the system that controls the flashlight. It is in a different place on different phones, you can specify a location manually or set one using the text box below"
        }
        Item {
            width: 1
            height: Theme.paddingLarge
        }
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Detect path")
            onClicked: {
                console.log("clicked!")
                led.detectPath()
                console.log("current value of controlFile is " + led.controlFile)
            }
        }
        Item {
            width: 1
            height: Theme.paddingLarge
        }

        TextField {
            focus: true
            inputMethodHints: Qt.ImhNoAutoUppercase
            softwareInputPanelEnabled: true
            width: parent.width
            font.pixelSize: Theme.fontSizeExtraSmall

            text: led.controlFile
            color: Theme.secondaryColor

            placeholderText: led.getPath()
            placeholderColor: Theme.secondaryColor

            // text displayed below textfield
            label: "enter a new path and press return"

        }


        Item {
            width: 1
            height: 2 * Theme.paddingLarge
        }
    }
}
