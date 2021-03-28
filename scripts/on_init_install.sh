apt-key list | grep “expired:”

sudo apt-key adv --keyserver keys.gnupg.net --recv-keys 65FFB764
sudo apt update && sudo apt install git openssh-server apt-transport-https -y --force-yes