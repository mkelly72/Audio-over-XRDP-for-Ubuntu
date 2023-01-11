#!/bin/bash

# To get audio working in xrdp

### Download and install dependencies and sources
sudo apt-get update
sudo apt-get install git libpulse-dev autoconf m4 intltool build-essential dpkg-dev libtool libsndfile-dev libspeexdsp-dev libudev-dev -y
sudo cp /etc/apt/sources.list /etc/apt/sources.list~
# The following line enables you to download from the source repositories
sudo sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list
sudo apt build-dep pulseaudio -y
cd /tmp
sudo apt source pulseaudio

### Build and install
pulsever=$(ls -d /tmp/pulseaudio*/ | head -c -1)
cd $pulsever
# This configure file may not exist - seems to build without it anyway
if test -f ./configure; then
	sudo ./configure
fi
sudo meson build
sudo meson compile -C build
sudo git clone https://github.com/neutrinolabs/pulseaudio-module-xrdp.git
cd pulseaudio-module-xrdp
sudo ./bootstrap
sudo ./configure PULSE_DIR="$pulsever"
sudo make
cd src/.libs
sudo install -t "/var/lib/xrdp-pulseaudio-installer" -D -m 644 *.so

### Start and enable service
sudo killall pulseaudio
systemctl --user start pulseaudio
systemctl --user enable pulseaudio

exit 0
