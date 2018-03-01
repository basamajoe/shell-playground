#!/bin/bash
HOST_ORIGIN=serverori
HOST_DESTINATION=serverdes
DBNAME=dbname

#It uses same user for both servers
read -p "user: " user
read -s -p "pass: " pass

# Export
mysqldump -u $user -p$pass -h $HOST_ORIGIN --databases $DBNAME > $DBNAME.sql

# Drop database ada
#mysqladmin -u$user -p$pass -h $HOST_DESTINATION drop $DBNAME
mysql -u$user -p$pass -h $HOST_DESTINATION -e "DROP DATABASE IF EXISTS $DBNAME"

#Create database adapters
#mysqladmin -u$user -p$pass -h $HOST_DESTINATION create databasename $DBNAME
mysql -u$user -p$pass -h $HOST_DESTINATION -e "CREATE DATABASE IF NOT EXISTS $DBNAME"

# Import
mysql -u$user -p$pass -h $HOST_DESTINATION --debug-info --progress-reports $DBNAME < $DBNAME.sql
