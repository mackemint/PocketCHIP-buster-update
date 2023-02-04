version=8_0.2.5f
wget www.lexaloffle.com/dl/chip/pico-$version_chip.zip
sudo unzip pico-$version_chip.zip -d /usr/lib
cp ../assets/libcurl.so.3 /usr/lib/pico-8
env LD_PRELOAD=/usr/lib/pico-8/libcurl.so.3 /usr/lib/pico-8/pico8
