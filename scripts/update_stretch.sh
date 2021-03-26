#Save old stuff, feeling nostalgic
cp /etc/apt/sources.list /etc/apt/sources.list~jessie
cp /etc/NetworkManager/NetworkManager.conf /etc/NetworkManager/NetworkManager.conf~jessie
cp /etc/X11/xorg.conf /etc/X11/xorg.conf~jessie
cp /home/chip/.config/awesome/rc.lua /home/chip/.config/awesome/rc.lua~jessie
#Update to new stuff
cp ../assets/sources_stretch.list  /etc/apt/sources.list
cp ../assets/NetworkManager.conf  /etc/NetworkManager/NetworkManager.conf
#Perform upgrade
sudo apt update --allow-insecure-repositories --allow-unauthenticated && sudo apt upgrade -y --force-yes --allow-unauthenticated && sudo apt dist-upgrade -y --force-yes --allow-unauthenticated && sudo apt autoremove -y
#Install new confs
cp ../assets/xorg.conf_debian9  /etc/X11/xorg.conf
cp ../assets/rc.lua  /home/chip/.config/awesome/rc.lua

systemctl stop wpa_supplicant
systemctl disable wpa_supplicant
