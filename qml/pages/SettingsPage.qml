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
import harbour.hammerhead.torch 0.1

Page {
    objectName: "SettingsPage"

    PageHeader {
        id: header
        title: qsTr("Settings")
    }

    SilicaFlickable {
        id: flickable

        anchors {
            top: header.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        contentHeight: content.height

        Column {
            id: content
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: Theme.paddingMedium
            anchors.rightMargin: Theme.paddingMedium


            Label {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Theme.fontSizeMedium
                color: Theme.primaryColor
                text: qsTr("Control file settings")
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
                text: "This page shows the path to the control file, which controls the state of the camera flash LED. This should be auto-detected; the current settings are shown below."
            }
            Item {
                width: 1
                height: Theme.paddingLarge
            }

            DetailItem {
                label: "Device"
                value: led.device
            }

            DetailItem {
                label: "Control file"
                value: led.controlFile
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


            Label {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Theme.fontSizeExtraSmall
                color: Theme.secondaryColor
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                text: "If your phone shows up as \"Unknown\" you can manually edit the configuration file at ~/.config/harbour-hammerhead-torch/harbour-hammerhead-torch.conf and specify the device name and path to the control file."
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
                text: "If your control file is not auto-detected please let me know so I can add support for your hardware."
            }

            Item {
                width: 1
                height: 2 * Theme.paddingLarge
            }
        }

        VerticalScrollDecorator {flickable: flickable}
    }
}
