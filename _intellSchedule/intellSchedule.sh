while true; do
	echo -n "Are you in job? [y/n] "
	read -k1 -s sn
	case $sn in
		n) cls;
		   while true; do
		   	echo -n "Are you going to work? [y/n] "
		   	read -k1 -s sn2

		   	if [ $sn2 = "y" ]
		   	then

				if test "$(date +%H)" -ge "19" || test "$(date +%H)" -le "08"; then
					nshift on; # OPTIONAL: MacOS Night Shift ON
				fi
				
				# Put here your fav commands during work out from university or job
	                   	break;

		   	elif [ $sn2 = "n" ]
		   	then

				if test "$(date +%H)" -ge "19" || test "$(date +%H)" -le "08"; then
					nshift on; # OPTIONAL: MacOS Night Shift ON
				fi
				# Put here your fav commands during free time
				break;
		   	else
			   	echo -n "Please give a valid option: [y/n]";
			fi
		   done

		   clear;
                   break;;

		s) # OPTIONAL: MacOS Night Shift OFF
		   nshift off;

		   # OPTIONAL: Mute volume in MacOS
		   osascript -e 'set volume output muted true';

		   # TimeDate now
		   day=$(date +%a);
		   hour=$(date +%H);

		   # OPTIONAL Correction Time: Rounding 10:55-10:59 to 11:00
		   mins=$(date +%M);
		   if test $mins -ge 55 && test $mins -le 59; then
			hour=$((hour + 1))
		   fi

		   # Reading job_calendar.csv
		   arr_d=($(cat "_intellSchedule/example_calendar.csv" | tr -s ";" " " | awk '{if (NR==1){print " "$1" "$2" "$3" "$4" "$5" "$6" "}}'))
		   arr_h=($(cat "_intellSchedule/example_calendar.csv" | tr -s ";" " " | awk '{ if (NR==1 || NR==2 || NR==3 || NR==4 || NR==5) print $1}' | cut -d ":" -f 1))

		   # get_index() function
		   pos_d=$(_intellSchedule/get_index.sh ${day} "${arr_d[@]}");
		   pos_h=$(_intellSchedule/get_index.sh ${hour} "${arr_h[@]}");

		   # Subject/task where I am
		   subj=$(cat "_intellSchedule/example_calendar.csv" | tr -s ";" " " | awk -v a=$pos_d -v b=$pos_h '{ if (NR==b) { print $a; }}')

		   # Bash-Switch to do some taks or others depending on the Subject
	           case $subj in
			# Introduce your commands depending on the subject or task you are, in this example, we are displaying a test MacOS alert 
		   	S1)		osascript -e 'display alert "YOU ARE IN '$subj'"';;
		   	S2)		osascript -e 'display alert "YOU ARE IN '$subj'"';;
		   	S3)		osascript -e 'display alert "YOU ARE IN '$subj'"';;
		   	S4)		osascript -e 'display alert "YOU ARE IN '$subj'"';;
		   	S5)	osascript -e 'display alert "YOU ARE IN '$subj'"';;
			# ... variable to your necesities
		   esac

		   clear;
		   break;;

		*) echo "Please introduce "y" o "n"";;
	esac
done
