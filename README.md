# Audio-over-XRDP-for-Ubuntu
Simple script to build Pulseaudio driver for audio over XRDP

I use Ubuntu on Hyper-V, and as you may know the only way to get proper video and audio over Hyper-V is through RDP. Ubuntu by default does not have a driver for audio over XRDP, and the instructions I have seen on the internet are quite complicated. And as you also probably know whenever packages are upgraded, drivers need to be rebuilt, which can happen frequently. So I created a simple script to make it easier and decided to share it on Github.

I use this script for my own purposes, so as long as it works for me I don't plan on frequently updating it. But feel free to use it, fork it, unfork it, whatever.