SYMBOLS=""
for symbol in {A..Z} {a..z} {0..9}; do SYMBOLS=$SYMBOLS$symbol; done
PWD_LENGTH=16  
PASSWORD=""    
RANDOM=256   
read logins_file

while read line
do
	PASSWORD=""  
	for i in `seq 1 $PWD_LENGTH`
		do 
		PASSWORD=$PASSWORD${SYMBOLS:$(expr $RANDOM % ${#SYMBOLS}):1}
		done
	##echo $PASSWORD
	htpasswd -b $logins_file $line $PASSWORD
	##curl -u $line:$PASSWORD http://localhost:8080
	curl -X POST "$line:$PASSWORD" http://localhost:8080

done < "${1:-dev/stdin}"
