my_process="sunvox_lofi" # check with htop that this is where the process runs from, might be usr/lib/pico8
#Make CPU hogs more polite
sudo renice 17 -p $(pidof /lib/systemd/systemd) 
sudo renice 17 -p $(pidof /lib/systemd/ubihealthd) 
sudo renice 17 -p $(pidof /usr/sbin/ubihealthd) 
sudo renice 17 -p $(pidof /usr/bin/pocket-home) 
sudo renice 17 -p $(pidof /usr/bin/X)

#Kill off some troublemakers
sudo pkill $(pidof /usr/bin/pocket-home) 

sudo systemctl --user stop pulseaudio.socket
sudo systemctl --user stop pulseaudio.service
sudo systemctl --user stop ubihealthd.service
$my_process &
sudo renice -20 -p $(pidof $my_process)  ; /usr/bin/pocket-home &
sudo systemctl --user start pulseaudio.socket
sudo systemctl --user start pulseaudio.service
sudo systemctl --user start ubihealthd.service
