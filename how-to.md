TL;DR:
Update to Stretch:
	cd scripts
	sudo ./update_stretch.sh
	wait...
	answer yes to restarts, no to everything else
	sudo shutdown -h now
    boot back up

Update to Buster:
	ssh in
	cd scripts
        sudo ./update_buster.sh
        wait...
	answer yes to restarts, no to everything else
        reboot
		

Upgrading to Stretch:

    replace /etc/apt/sources.list  -> wget http://maba.dk/sources_stretch.list
    apt-get update
    apt-get upgrade
    apt-get dist-upgrade
    replace /etc/NetworkManager/NetworkManager.conf -> assets/NetworkManager.conf
    replace /etc/X11/xorg.conf -> wget maba.dk/xorg.conf_debian9
    replace ~/.config/awesome/rc.lua -> wget maba.dk/rc.lua

    Reboot


Upgrading to Debian 10:

    replace /etc/apt/sources.list -> wget http://maba.dk/sources_buster.list
    apt-get update
    apt-get upgrade
    apt-get dist-upgrade
    replace /etc/X11/xorg.conf -> wget maba.dk/xorg.conf_debian10

Reboot

Check documentation on how to setup wifi http://chip.jfpossibilities.com/docs/pocketchip.html
Check the Readme on how to get pico8 working
