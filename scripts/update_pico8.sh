
wget www.lexaloffle.com/dl/chip/pico-8_0.2.2c_chip.zip
sudo unzip pico-8_0.2.2c_chip.zip -d /usr/lib
cp ../assets/libcurl.so.3 /usr/lib/pico-8
env LD_PRELOAD=/usr/lib/pico-8/libcurl.so.3 /usr/lib/pico-8/pico8
