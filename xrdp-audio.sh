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
sudo install -t "/var/lib/xrdp-pulseaudio-installer" -D -m 755 *.so

### Start and enable service
sudo killall pulseaudio
systemctl --user start pulseaudio
systemctl --user enable pulseaudio

### Add ~/.pulse.sh to Startup Applications to fix initial startup issues
cd /$HOME
tee /$HOME/.pulse.sh <<EOF
#!/bin/bash
systemctl --user restart pulseaudio
exit 0
EOF

chmod +x ~/.pulse.sh
if [ ! -f /$HOME/.config/autostart/.pulse.sh.desktop ]; then
tee /$HOME/.config/autostart/.pulse.sh.desktop <<EOF

[Desktop Entry]
Exec=$HOME/.pulse.sh
Icon=dialog-scripts
Name=Restart Pulseaudio
Path=
Type=Application
X-KDE-AutostartScript=true
X-GNOME-Autostart-enabled=true
EOF
fi

exit 0
