tar xfvz ../assets/mmc2-4.4.13-ntc-mlc.tar.gz
mkdir /lib/firmware/overlays
cp ../assets/mmc2-4.4.13-ntc-mlc/mmc2-ntc.dtbo /lib/firmware/overlays/
cp ../assets/mmc2-4.4.13-ntc-mlc/mmc2-overlay.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable mmc2-overlay