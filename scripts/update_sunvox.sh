
wget https://www.warmplace.ru/soft/sunvox/sunvox-1.9.6c.zip
unzip sunvox-1.9.6c.zip
sudo cp /usr/bin/sunvox_lofi /usr/bin/sunvox_lofi~
sudo cp sunvox/sunvox/linux_arm_armhf_raspberry_pi/sunvox_lofi /usr/bin/
cp ../assets/sunvox_config.ini /home/chip/.config/SunVox/
rm -r sunvox/
rm sunvox-*.zip
