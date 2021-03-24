mv /etc/apt/sources.list /etc/apt/sources.list~jessie
cp ../assets/sources_stretch.list  /etc/apt/sources.list
cp ../assets/NetworkManager.conf  /etc/NetworkManager/NetworkManager.conf

sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade -y

cp ../assets/xorg.conf_debian9  /etc/X11/xorg.conf
cp ../assets/rc.lua  ~/.config/awesome/rc.lua


