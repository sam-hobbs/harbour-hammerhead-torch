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
    id: page

    // PullDownMenu must be inside flickable element
    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
        }

        PageHeader {
            id: header
            title: qsTr("Hammerhead Torch")
        }

        IconButton {
            id:button

            anchors {
                top: header.bottom
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }

            width: parent.width

            icon.source: ( led.on ) ? "qrc:///hammerhead-inverted" : "qrc:///hammerhead"

            icon.width: parent.width
            icon.height: parent.height - header.height
            icon.fillMode: Image.PreserveAspectFit

            onClicked:
            {
                console.log("clicked!")
                led.toggleState()
            }
        }
    }


    // if this is the first time the application has run, open a dialog to ask the user to set the torch method (gstreamer or controlfile)
    property bool firstLoad: true
    onStatusChanged: {
        if (status == PageStatus.Active && firstLoad) {
            firstLoad = false
            if (!led.getGSTDialogCompleted()) {
                pageStack.push(Qt.resolvedUrl("DoesGStreamerWorkDialog.qml"));
            }
        }
    }
}


