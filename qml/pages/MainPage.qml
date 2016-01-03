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
    id: page

    // PullDownMenu requires page to be flickable
    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
        }

        Column {
            id: column
            width: parent.width

            PageHeader {
                title: qsTr("Hammerhead Torch")
            }
        }

        IconButton {
            id:button

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width

            icon.source: ( led.isOn() ) ? "qrc:///hammerhead-inverted" : "qrc:///hammerhead"

            icon.width: parent.width
            icon.fillMode: Image.PreserveAspectFit

            onClicked:
            {
                console.log("clicked!")
                led.toggleState()
                icon.source = ( led.isOn() ) ? "qrc:///hammerhead-inverted" : "qrc:///hammerhead"

            }


        }

    }

    onStatusChanged:
    {
        console.log("page status " + page.status)
        if ( page.status == PageStatus.Active )
            button.icon.source = ( led.isOn() ) ? "qrc:///hammerhead-inverted" : "qrc:///hammerhead"
    }

}


