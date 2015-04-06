#!/bin/bash

# Adapted from: https://gist.github.com/coderua/5592d95970038944d099
# And https://github.com/CentOS/CentOS-Dockerfiles/blob/master/mariadb/centos7/config_mariadb.sh

__mysql_config() {
# Hack to get MySQL up and running... I need to look into it more.
echo "Running the Mariadb init function."

mysql_install_db
chown -R mysql:mysql /var/lib/mysql
/usr/bin/mysqld_safe & 
sleep 10
}

#Call the function
__mysql_config

# Setup root password
CURRENT_MYSQL_PASSWORD=''
NEW_MYSQL_PASSWORD=`pwgen -cn 12 1`
 
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

echo -e "\033[0;32mMariadb username: \033[0;33mroot \033[0;32mPassword is: \033[0;33m$NEW_MYSQL_PASSWORD\033[0m"

exit 0
