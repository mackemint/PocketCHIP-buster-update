my_process="bin/lgpt.rpi-exe" # check with htop that this is where the process runs from, might be usr/lib/pico8
#Make CPU hogs more polite
sudo renice 17 -p $(pidof /lib/systemd/systemd) 
sudo renice 17 -p $(pidof /lib/systemd/ubihealthd) 
sudo renice 17 -p $(pidof /usr/sbin/ubihealthd) 
sudo renice 17 -p $(pidof /usr/bin/pocket-home) 
sudo renice 17 -p $(pidof /usr/bin/X)
sudo renice -20 -p $(pidof /usr/bin/pulseaudio)

#Kill off some troublemakers
sudo pkill $(pidof /usr/bin/pocket-home) &
sudo pkill -KILL -u chip $(pidof /usr/bin/pocket-home) &

#sudo pulseaudio -D
cd lgpt_chip
$my_process &
sudo renice -20 -p $(pidof $my_process) ; /usr/bin/pocket-home
