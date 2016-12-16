#!/bin/bash
#sh convert.sh data_file proj.deal number_columns
filename="$1"
rules="$2"
Col="$3"
cnt=1
miss="?"
echo "%facts" >> trial.deal

while read -r line
do
	col=1
    for word in $line
	do
	ch=$(( cnt%4 ))
	if [ $word = $miss ]
	then
		#echo $word
		word="na"
	fi
	if [ $ch -eq 1 ]
	then
		if [ $col -le $Col ]
		then
        	echo "testdata($cnt,$col,$word)." >> trial.deal
			col=$(( col+1 ))
		else
			echo "testlabels($cnt,$word)." >> trial.deal
		fi
    else
        #echo "$line" >> trial.txt
		if [ $col -le $Col ]
		then
        	echo "patterns($cnt,$col,$word)." >> trial.deal
			col=$(( col+1 ))
		else
			echo "labels($cnt,$word)." >> trial.deal
		fi
#		$col = $col + 1
	fi
	done
	cnt=$(( cnt+1 ))
done < "$filename"
echo "%rules" >> trial.deal
while read -r line
do
	echo "$line" >> trial.deal
done < "$rules"
