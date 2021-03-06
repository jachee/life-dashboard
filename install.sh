#!/bin/sh

ssh root@192.168.15.244 "/usr/sbin/mntroot rw"

scp periodic-display.sh root@192.168.15.244:/periodic-display.sh
scp target/arm-unknown-linux-musleabi/release/life-dashboard root@192.168.15.244:/main
scp pokemon.zip root@192.168.15.244:/pokemon.zip

ssh root@192.168.15.244 << EOF
  mkdir pokemon
  unzip pokemon -d pokemon
  cd /
	chmod 777 periodic-display.sh
	chmod 777 main
	shutdown -r now
	echo "Install complete, unplug Kindle now (or it will mess up the USB connection)."
EOF

echo "add '*/30 * * * * /periodic-display.sh' to cron file (vi /etc/crontab/root)."
