# Hammerhead Torch
A simple torch app, originally written for the LG Nexus 5 (codename "hammerhead") port of Sailfish OS.

Hammerhead Torch now automatically detects the following hardware:
* Jolla A
* LG Nexus 5 ("Hammerhead")
* Fairphone 2
* Motorola Photon Q

Support can be added for any device with an LED that can be controlled using a simple switch file (i.e. file contents 1 for on, 0 for off) by mapping the hardware device name found in /etc/hw-release to the control file path using controlfile.conf.

Feel free to submit a pull request or contact me to add auto-detection support for your device.
