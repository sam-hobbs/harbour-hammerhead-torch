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
import QtMultimedia 5.5
import "pages"

ApplicationWindow
{
    initialPage: Component { MainPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: Orientation.All
    _defaultPageOrientations: Orientation.All

    // class defined in ledcontrol.h for interacting with led controls
    LEDControl {
        id: led
        on: led.isOn() // TODO fix warning "unable to assign a function to a property of any type other than var"
        controlFile: led.getPath()
        device: led.getDevice()
        brightness: led.getBrightness();
    }

    Camera {
        id:camera
        //flash.mode: Camera.FlashTorch
        //flash.mode: ( led.on ) ? Camera.FlashTorch : Camera.FlashOff
        flash.mode: ( led.qtMultimediaOn ) ? Camera.FlashTorch : Camera.FlashOff
    }

//    Torch {
//        power: 100
//        //enabled: true
//        enabled: led.on
//    }

}


