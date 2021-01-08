#!/bin/bash

SYMBOLS=""
for symbol in {A..Z} {a..z} {0..9}; do SYMBOLS=$SYMBOLS$symbol; done
RANDOM=256
PASSWORD_LENGTH=16 

function create_password { 
	PASSWORD=""    
	for i in `seq 1 $PASSWORD_LENGTH`; do
		PASSWORD=$PASSWORD${SYMBOLS:$(expr $RANDOM % ${#SYMBOLS}):1}
	done
	echo $PASSWORD
}


while [ -n "$1" ]
do
	case "$1" in
		--loginspath) loginspath=$2; shift;;
		--login) login="$2"; shift ;;
		--passpath) passpat="$2"; shift;;
		--webhook) webhook="$2"; shift;;
		*) echo "$1 is not an option";; 
	esac
	shift
done


if [[ ( $loginspath = "" ) && ( $login = "" ) ]]
then
    echo "no loginspath and login"
    exit
elif [ $webhook = "" ]
then
    echo "no webhook"
elif [ $passpath = "" ]
then
    echo "no passpath"
fi


if [[ -e $LOGINS ]]
then
    while read login; do
    pas=$(create_password)
    htpasswd -b $passpath $login $pas
    curl -X POST "$login:$pas" "$webhook"
    done < "$LOGINS_FILE"
    exit
else
    pas=$(create_password)
    htpasswd -b $passpath $login $pas
    curl -X POST "$login:$pas" "$webhook"
fi
exit
