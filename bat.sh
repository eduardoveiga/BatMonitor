
suspended=0;
percent50=0;
percent25=0;
percent20=0;
user=$user;

while true
do
	battery_level=$(acpitool -b | awk -F',' '{print $2}' | sed -e 's/ //g' -e 's/\.[0-9]*%//');
	battery_status=$(acpitool -a | awk -F':' '{print $2}'| sed 's/ //g');
	
	
	
	
	
	if [ $battery_level -le 10 ] && [ $battery_status = "off-line" ]
	then
		sudo halt;
		
	elif [ $battery_level -le 15 ] && [ $battery_status = "off-line" ] && [ $suspended -eq 0 ]
	then
		su -c "notify-send '$battery_level% de bateria'" -s /bin/sh $user
		sleep 5;
		sudo pm-suspend;
		suspended=1;
		percent20=1;
		percent25=1;
		percent50=1;

	elif [ $battery_level -le 20 ] && [ $battery_status = "off-line" ] && [ $percent20 -eq 0 ]
	then
		su -c "notify-send '$battery_level% de bateria'" -s /bin/sh $user;
		percent20=1;
		percent25=1;
		percent50=1;
	
	elif [ $battery_level -le 25 ] && [ $battery_status = "off-line" ] && [ $percent25 -eq 0 ]
	then
		su -c "notify-send '$battery_level% de bateria'" -s /bin/sh $user;
		percent25=1;
		percent50=1;
	
	elif [ $battery_level -le 50 ] && [ $battery_status = "off-line" ] && [ $percent50 -eq 0 ]
	then
		su -c "notify-send '$battery_level% de bateria'" -s /bin/sh $user;
		percent50=1;

	elif [ $battery_status = "online" ]
	then
		suspended=0;
		percent50=0;
		percent25=0;
		percent20=0;
	fi
	

	sleep 60;

done


