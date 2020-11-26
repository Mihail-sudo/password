#!/bin/bash

SYMBOLS=""
for symbol in {A..Z} {a..z} {0..9}; do SYMBOLS=$SYMBOLS$symbol; done
PASSWORD_LENGTH=16  
PASSWORD=""    
RANDOM=256   

while read login; do
	PASSWORD=""
	for i in `seq 1 $PASSWORD_LENGTH`; do
		PASSWORD=$PASSWORD${SYMBOLS:$(expr $RANDOM % ${#SYMBOLS}):1}
	done
	echo $PASSWORD
	htpasswd -b $2 $login $PASSWORD
	##curl -u $line:$PASSWORD http://localhost:8080
	curl -X POST "$login:$PASSWORD" http://localhost:8080

done < "${1:-dev/stdin}"
