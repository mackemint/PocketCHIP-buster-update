my_process="env LD_PRELOAD=/usr/lib/pico-8/libcurl.so.3 /usr/lib/pico-8/pico8 -splore" # check with htop that this is where the process runs from, might be usr/lib/pico8
#Make CPU hogs more polite
sudo renice 17 -p $(pidof /lib/systemd/systemd) 
sudo renice 17 -p $(pidof /lib/systemd/ubihealthd) 
sudo renice 17 -p $(pidof /usr/sbin/ubihealthd) 
sudo renice 17 -p $(pidof /usr/bin/pocket-home) 
sudo renice 17 -p $(pidof /usr/bin/X)

#Kill off some troublemakers
sudo pkill $(pidof /usr/bin/pocket-home) 
#pulseaudio -k &
systemctl --user stop pulseaudio.socket
systemctl --user stop pulseaudio.service
$my_process &
#pulseaudio -k &
sudo renice -20 -p $(pidof $my_process)  ; /usr/bin/pocket-home ; systemctl --user start pulseaudio.socket
systemctl --user start pulseaudio.service

