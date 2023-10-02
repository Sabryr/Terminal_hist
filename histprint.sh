#!/bin/bash
#./histprint.sh /cluster/home/$USER/.new_bash_history

connect () {
	export SHARED_HISTORY_FILE=$1
	last_printed="NA"
	i=1;
	echo "History file is $SHARED_HISTORY_FILE"
	while [ $? -eq "0" ];
	do
		last=$(tail -n 1 $SHARED_HISTORY_FILE)
        	last_base=$(echo $last | awk '{print $1}')
        	command -v "$last_base"  > /dev/null 2>&1
		if [[  $? -eq "0" ]] || [[ "$last" == *http* ]] || [[ "$last" == *STOP* ]]
        	then
			if [[ "$last_base" == "STOP" ]]
			then
				echo "END" >> $SHARED_HISTORY_FILE
				exit 0
			elif [ "$last" != "$last_printed" ]
                	then
                        	last_printed="$last"
				#printf '\033]2;'$last_printed'\007'
                                #printf "($i) $last_printed | "
                                printf "$last_printed \n"
				
                                if [ $(($i % 5)) == 0 ]
				then
					echo ""
  				fi
                                i=$((i+1))


                        elif [[ "$last" == *http* ]]
                        then
                        	last_printed="$last"
				#echo "$last_printed"
				#printf '\033]2;'last_printed'\007'
				#set-title "$last_printed"
                        fi
        	fi
		sleep 2

	done;
}

#set-title(){
#  ORIG=$PS1
#  TITLE="\e]2;$1\a"
#  PS1=${ORIG}${TITLE}
#  }
#

connect $1


