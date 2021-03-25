cp /etc/apt/sources.list /etc/apt/sources.list~jessie
cp ../assets/sources_stretch.list  /etc/apt/sources.list
cp ../assets/NetworkManager.conf  /etc/NetworkManager/NetworkManager.conf

sudo apt update --allow-insecure-repositories --allow-unauthenticated && sudo apt upgrade -y --force-yes --allow-unauthenticated && sudo apt dist-upgrade -y --force-yes --allow-unauthenticated

cp ../assets/xorg.conf_debian9  /etc/X11/xorg.conf
cp ../assets/rc.lua  /home/chip/.config/awesome/rc.lua


