while true; do
	echo -n "Are you in university? [y/n] "
	read -k1 -s sn
	case $sn in
		n) cls;
		   while true; do
		   	echo -n "Are you going to work? [y/n] "
		   	read -k1 -s sn2

		   	if [ $sn2 = "y" ]
		   	then

				if test "$(date +%H)" -ge "19" || test "$(date +%H)" -le "08"; then
					nshift on;
				fi

				osascript -e 'set volume output muted false';
				spotify play uri spotify:playlist:3nHIT4hewxqSGF9RZcCXWz;
			   	spotify toggle shuffle;
	                   	aula_virtual; break;

		   	elif [ $sn2 = "n" ]
		   	then

				if test "$(date +%H)" -ge "19" || test "$(date +%H)" -le "08"; then
					nshift on;
				fi

			   	osascript -e 'set volume output muted false';
			        osascript -e 'display alert "Disfruta del tiempo libre"';
			   	(/Applications/Firefox.app/Contents/MacOS/firefox 'https://twitter.com' & ) && sleep 1; clear; neofetch; break;

		   	else
			   	echo -n "Please give a valid option: [y/n]";
			fi
		   done

		   cls;
                  break;;

		s) # Night Shift OFF
		   nshift off;

		   # Mute volume in MacOS
		   osascript -e 'set volume output muted true';

		   # TimeDate now
		   dia=$(date +%a);
		   hora=$(date +%H);

		   # Correction Time: Rounding 10:55-10:59 to 11:00
		   mins=$(date +%M);
		   if test $mins -ge 55 && test $mins -le 59; then
			hora=$((hora + 1))
		   fi

		   # Reading uni_cal.csv
		   arr_d=($(cat "_intellSchedule/uni_cal.csv" | tr -s ";" " " | awk '{if (NR==1){print " "$1" "$2" "$3" "$4" "$5" "$6" "}}'))
		   arr_h=($(cat "_intellSchedule/uni_cal.csv" | tr -s ";" " " | awk '{ if (NR==1 || NR==2 || NR==3 || NR==4 || NR==5) print $1}' | cut -d ":" -f 1))

		   # get_index() function
		   pos_d=$(_intellSchedule/get_index.sh ${dia} "${arr_d[@]}");
		   pos_h=$(_intellSchedule/get_index.sh ${hora} "${arr_h[@]}");

		   # Subject where I am
		   asig=$(cat "_intellSchedule/uni_cal.csv" | tr -s ";" " " | awk -v a=$pos_d -v b=$pos_h '{ if (NR==b) { print $a; }}')

		   # Bash-Switch to do some taks or others depending on the Subject
	           case $asig in

		   	SD)		osascript -e 'display alert "YOU ARE IN '$asig'"';;
		   	SE)		osascript -e 'display alert "YOU ARE IN '$asig'"';;
		   	IA)		osascript -e 'display alert "YOU ARE IN '$asig'"';;
		   	AMPLI)		osascript -e 'display alert "YOU ARE IN '$asig'"';;
		   	LENGUAJES)	osascript -e 'display alert "YOU ARE IN '$asig'"';;

		   esac

		   cls;
		   break;;

		*) echo "Please introduce "y" o "n"";;
	esac
done
