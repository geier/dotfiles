#!/bin/zsh

COLOR=True

RUN=0

checkMail () {
	local -A counts; local i

	for i in "${MAILDIR:-${HOME}/Mail}"/**/INBOX/new/*
		{ (( counts[${i:h:h:t}]++ )) }
	for i in ${(k)counts}
		{ print -n $counts[$i]' ' }
} 

i3status | while :
do
	# i3status lesen:
	read line
	COLOR="#dc322f"
	 
	MAILS=$(checkMail) &> /dev/null
	if [ x"$MAILS" = x ]; then
		MAILS=0
		COLOR="#FFFFFF"
	fi

		if [[ $RUN -ge 3 ]]
		then
			echo ",[{\"name\":\"mail\", \"color\":\"$COLOR\",\"full_text\":\"✉ $MAILS\"},${line:2}" || exit 1
		else
			echo $line
			let RUN=RUN+1
		fi

done
