# PocketCHIP-buster-update

TL;DR: Check the how-to.md

Thanks to:

	maba.dk for which this whole guide wouldn't have happened
	NightRadio that helped me fix a lot of audio glitches
	aleh for their excellent battery monitor
	htkasm on Reddit for keeping the Wifi alive

Updating to Buster:
The whole process took about half a work-day with check-ins here and there while the unit chugged along, which gave me a perfect opportunity to procrastinate from painfully boring work. :D

How to update the kernel:
	https://github.com/kaplan2539/CHIP-Debian-Kernel

I'd tried this a bunch of times before but never suceeded to get the screen past the loading bubble and/or getting the wifi up again post update.
I started getting sick of not being able to install the things I needed so I thought - what the heck, let's get cracking.

I found some good advice on how to keep the Wifi intact here:
https://www.reddit.com/r/ChipCommunity/comments/htkasm/chip_flashing_guide_july_2020/

	Edit /etc/NetworkManager/NetworkManager.conf (or a conf.d file) and add the following:

	[connection]
	wifi.mac-address-randomization=1

	[device]
	wifi.scan-rand-mac-address=no

This guide managed to get me up to Stretch, but I got the same problem as usual - screen black after loading bubble. Wifi still intact though thanks to the previous step with NetworkManager
http://maba.dk/index.php/demo/pocketchip/

I thought - what the heck, can't ruin it more than this so I immediately started upgrading to Buster. Apt upgrade complained on a couple of dependencies, had to install them manually:

	sudo apt install -y libegl1 libgles1 libgles2 libwayland-egl1 libwayland-egl1-mesa

Pushing through the guide, I chose to use the managers' versions instead of my own for all prompts of the sort except for one - pulseaudio. I'd configured pulseaudio painstakingly well so I wasn't up to reconfiguring it again. Maybe not the best choice in retrospect, maybe should have kept them as-is but I basically don't know what I'm doing here so don't shoot me.

Rebooting one last time and lo and behold!
The thing boots up again with a login screen which takes me to the pocket-home! Sweet =3

No Wifi though. D'oh!
The command

	nmcli device wifi list

returned simply

	IN-USE  SSID  MODE  CHAN  RATE  SIGNAL  BARS  SECURITY

	IN-USE  SSID  MODE  CHAN  RATE  SIGNAL  BARS  SECURITY

C'mon man! :(
This guide gave me no luck at all:
	https://www.reddit.com/r/ChipCommunity/comments/g0284k/wifi_not_starting_automatically_after_upgrading/
Maybe I'm just stupid, but it didn't change anything (i'm probably stupid, sorry)

Then I realized, maybe the NetworkManager.conf file was corrupted during the upgrade since I was silly enough to pick maintainer versions of the confs without really considering what they were.

Cracked it open in nano and found the last few lines I couldn't remember from the previous visit:

	[main]
	plugins=ifupdown,keyfile

	[connection]
	wifi.mac-address-randomization=1

	[device]
	wifi.scan-rand-mac-address=no

	[ifupdown]
	managed=false

	[keyfile]
	unmanaged-devices=interface-name:wlan1

That turned out to be a red herring, the issue is that PocketCHIP sometimes doesn't enable WIFI when rebooting, only when power cycling.
Thanks to user papasfritas on Reddit:

    https://www.reddit.com/r/ChipCommunity/comments/jlh83b/chip_and_debian_10_issues_gui_startx/
    
Still no Wifi though. Grumble..

Tried nmcli again

	wlan1: unmanaged
	        "wlan1"
	        wifi (rtl8723bs), 7E:C7:09:B5:6B:14, hw, mtu 1500
	 
	usb0: unmanaged
	        "usb0"
	        ethernet (musb-hdrc), 4A:82:27:6D:8C:2E, hw, mtu 1500

	sit0: unmanaged
	        "sit0"
	        iptunnel (sit), sw, mtu 1480

	lo: unmanaged
	        "lo"
	        loopback (unknown), 00:00:00:00:00:00, sw, mtu 65536

	wlan0: unmanaged
	        "wlan0"
	        wifi (rtl8723bs), 7C:C7:09:B5:6B:14, hw, mtu 1500

Hey wow! Something works, seems like wlan0 has evolved into wlan1 for some reason beyond me!
Tried

	nmcli device wifi list

which returned

	IN-USE  SSID              MODE      CHAN  RATE       SIGNAL   BARS  SECURITY
	        redacted 054         Infra  11    195 Mbit/s  100     ▂▄▆█  WPA2
	        redacted_6C1D13      Infra  1     195 Mbit/s  55      ▂▄__  WPA2
	        redacted Work        Infra  1     195 Mbit/s  55      ▂▄__  WPA2 802.1X
	        redacted Public      Infra  1     195 Mbit/s  50      ▂▄__  WPA2
	        redactednergi        Infra  6     195 Mbit/s  44      ▂▄__  WPA2
	        --                   Infra  6     195 Mbit/s  44      ▂▄__  WPA2

	IN-USE  SSID  		 MODE       CHAN  RATE       SIGNAL   BARS  SECURITY

Oh my, I'm on to something!

According to the guide (http://chip.jfpossibilities.com/docs/pocketchip.html), this will do things:
	
	sudo nmcli device wifi connect '(your wifi network name/SSID)' password '(your wifi password)' ifname wlan0

Since I have an evolved form of wifi now, I went:

	sudo nmcli device wifi connect '(your wifi network name/SSID)' password '(your wifi password)' ifname wlan1

Boom! Connected

ping 8.8.8.8 returned the glorious sign of being in touch with the world again:

	chip@chip:~$ ping 8.8.8.8
	PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
	64 bytes from 8.8.8.8: icmp_seq=1 ttl=251 time=25.8 ms
	64 bytes from 8.8.8.8: icmp_seq=2 ttl=251 time=23.8 ms

Sweet.

The login screen started bugging me out, so I went to my local /etc/lightdm/lightdm.conf
down to the [Seat:*]-section and modified the autologin-user and autologin-user-timeout to:

	autologin-user=chip
	autologin-user-timeout=0

The Wifi screen on pocket-home doesn't work still, so I'll have to figure that out..

Pico8 dissappeared for some reason. Got the latest one like so:

	wget www.lexaloffle.com/dl/chip/pico-8_0.2.2c_chip.zip
	sudo unzip pico-8_0.2.2c_chip.zip -d /usr/lib

This seems to require libcurl3, which isn't available for Buster.

	/usr/lib/pico-8/pico8: /usr/lib/arm-linux-gnueabihf/libcurl.so.4: version `CURL_OPENSSL_3' not found (required by /usr/lib/pico-8/pico8)

I placed the libcurl.so.3 in the same folder as pico8 /usr/lib/pico-8
then prepended the execution of pico8 in my script with an
	env LD_PRELOAD=/usr/lib/pico-8/libcurl.so.3
Voila! Back to crunching in Celeste you! =D

 
I remade the homescreen to fit my needs, it goes here
	/usr/share/pocket-home/config.json
together with the files in assets/appIcons



Audio glitches:

A huge problem with CHIP is that anything audio-related will stutter.
This repo solves a lot of the problems:

	https://github.com/aleh/pocketchip-batt

I also made a collection of scripts (scripts folder in this repo) that will mitigate this even further
My scripts require sudo to run, if you don't wanna type passwords you can add them to sudoers
	sudo nano /etc/sudoers

The nuclear option is to disable pulseaudio:
	pulseaudio -k 
until it complains that the process isn't there, then rename the binary 
	mv /usr/bin/pulseaudio  /usr/bin/pulseaudio~
Haven't found any downsides to doing this though

TODO:
	Figure out how to get wlan0 back again
	Get a halfway decent video player for Youtube streaming working
