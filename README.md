# Audio-over-XRDP-for-Ubuntu
Simple script to build Pulseaudio driver for audio over XRDP

I use Ubuntu on Hyper-V, and as you may know the only way to get proper video and audio over Hyper-V is through RDP. Ubuntu by default does not have a driver for audio over XRDP, and the instructions I have seen on the internet to build one are quite complicated. And as you also probably know, whenever dependancy packages are upgraded, the drivers they depend on need to be rebuilt, which can happen frequently. So I created a simple script to make the process easier and decided to share it on Github.

I use this script for my own purposes, so as long as it works for me I don't plan on frequently updating it. But feel free to use it, copy it, fork it, unfork it, whatever.

Just download the script, make it executable, and run it as the local user, but be prepared to supply a SUDO password. It should work for any .deb based distros, but I only tested it on my own Ubuntu system.
