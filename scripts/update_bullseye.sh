cp ../assets/sources_bullseye.list  /etc/apt/sources.list
apt update && apt upgrade -y && apt dist-upgrade -y
cp ../assets/xorg.conf_debian11  /etc/X11/xorg.conf