#!/bin/zsh

RUN=0

checkMail () {
	local -A counts; local i

	for i in "${MAILDIR:-${HOME}/Mail}"/**/INBOX/new/*
		{ (( counts[${i:h:h:t}]++ )) }
	for i in ${(k)counts}
		{ print -n $counts[$i]' ' }
} 

if type "condor_status" > /dev/null; then
    condorStatus () {
        # condor stat abrufen:
        CONDOR=`condor_status -submitters |egrep "^(nice-user.)?$USER@" |head -n 2|paste -d " " - -`
    
        if [[ $CONDOR == *nice-user* ]]; then
            STAT=`head -n 2 |paste -d " " - - |awk '{print "R: "$3"("$8") W: "$4"("$9") H: "$5"("$10")"}' <<< $CONDOR`
            #STAT=`awk '{ print "R: "$3, "I: "$4, "H: "$5 " @nice" }' <<< $GREP_NICE`
        elif [ -n "$CONDOR" ]; then
            STAT=`awk '{ print "R: "$3, "W: "$4, "H: "$5 }' <<< $CONDOR`
        else
        STAT="condor idle"
        fi
        print $STAT
    }
else
    condorStatus () {
    }
fi

i3status | while :
do
	# i3status lesen:
	read line
	COLOR="#dc322f"
	 
	MAILS=$(checkMail) &> /dev/null
	CONDOR=$(condorStatus) &> /dev/null
	if [ x"$MAILS" = x ]; then
		MAILS=0
		COLOR="#FFFFFF"
	fi

		if [[ $RUN -ge 3 ]]; then
			echo ",[{\"name\":\"mail\", \"color\":\"$COLOR\",\"full_text\":\"✉ $MAILS\"},{\"name\":\"condor_stat\",\"full_text\":\"$CONDOR\"},${line:2}" || exit 1
		else
			echo $line
			let RUN=RUN+1
		fi
done
