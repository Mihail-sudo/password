this programm creates a passwords for logins from file (or only one login) and makes url POST request for web
--loginspath (param for file with logins)
--login (param if u want to make only one password)
--passpath (it's file where are all logins with their passwords)
--webhook (param for web u want to sent a POST request)

good example:
./create_password.sh --loginspath /User/.../logins.txt --passpath /User/.../.psswrd --webhook hello.com

bad example:
./create_password.sh --loginspath /User/.../logins.txt --login user123 --passpath /User/.../.psswrd --webhook hello.com
(this programm will work only with file)
or 
./create_password.sh --passpath /User/.../.psswrd --webhook hello.com
(no loginspath and login)

WARNING
file with logins must have emty string at the end
(last login won't be readen without it)
