#!/bin/bash

# Adapted from: https://gist.github.com/coderua/5592d95970038944d099

# Setup root password
CURRENT_MYSQL_PASSWORD=''
NEW_MYSQL_PASSWORD= `pwgen -cny 12 1`
 
SECURE_MYSQL=$(expect -c "

set timeout 3
spawn mysql_secure_installation

expect \"Enter current password for root (enter for none):\"
send \"$CURRENT_MYSQL_PASSWORD\r\"

expect \"root password?\"
send \"y\r\"

expect \"New password:\"
send \"$NEW_MYSQL_PASSWORD\r\"

expect \"Re-enter new password:\"
send \"$NEW_MYSQL_PASSWORD\r\"

expect \"Remove anonymous users?\"
send \"y\r\"

expect \"Disallow root login remotely?\"
send \"y\r\"

expect \"Remove test database and access to it?\"
send \"y\r\"

expect \"Reload privilege tables now?\"
send \"y\r\"

expect eof
")
 
#
# Execution mysql_secure_installation
#
echo "${SECURE_MYSQL}"

echo "Mariadb username: root Password is: $NEW_MYSQL_PASSWORD"

exit 0