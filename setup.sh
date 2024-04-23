#!/bin/bash

apt install -qq git
git clone https://github.com/goodtft/LCD-Show /home/pi/lcd-show

# Disable reboot, we do that on our own terms
sed -i 's/sudo reboot//g' /home/pi/lcd-show/LCD35-show /home/pi/lcd-show/rotate.sh

cd /home/pi/lcd-show && ./LCD35-show 180

if ! grep "dtoverlay=gpio-key,gpio=" /boot/config.txt; then
  echo "dtoverlay=gpio-key,gpio=21,keycode=28" >> /boot/config.txt
fi

cat >/usr/share/applications/pluslife.desktop <<'EOF'
[Desktop Entry]
Name=Pluslife Analyzer
Comment=Analyzes Pluslife
Icon=/opt/pluslife.png
Exec=bash -c '/usr/bin/chromium-browser --no-first-run --noerrdialogs --start-maximized --touch-devices=$(xinput list --id-only "ADS7846 Touchscreen") --enable-pinch --disable-notifications --disable-infobars --app=file:///opt/virus.sucks/pluslife_app/index.html'
Type=Application
Encoding=UTF-8
Terminal=false
Categories=Internet;
EOF

ln -sf /usr/share/applications/pluslife.desktop /etc/xdg/autostart/pluslife.desktop

if ! [ -e /opt/virus.sucks/pluslife_app/index.html ]; then
  cd /opt && wget --convert-links --recursive https://virus.sucks/pluslife_app/
  python3 <<EOF
import bs4
with open("/opt/virus.sucks/pluslife_app/index.html") as f:
  soup = bs4.BeautifulSoup(f.read(), 'lxml')
soup.find("a").extract(); soup.find("h1").extract(); soup.find("p").extract()
with open("/opt/virus.sucks/pluslife_app/index.html", "w") as f:
  f.write(str(soup))
EOF
fi

if ! [ -e /opt/pluslife.png ]; then
  apt install -yy webp
  dwebp /opt/virus.sucks/pluslife/power.webp -o /opt/pluslife.png -scale 64 64
fi
