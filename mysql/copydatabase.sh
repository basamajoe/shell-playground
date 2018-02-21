#!/bin/bash
DBADA_PRE=serverpre
DBADA_DEV=serverdev
DBNAME=dbname

read -p "user: " user
read -s -p "pass: " pass

# Export
mysqldump -u $user -p$pass -h $DBADA_PRE --databases $DBNAME > $DBNAME.sql

# Drop database ada
#mysqladmin -u$user -p$pass -h $DBADA_DEV drop $DBNAME
mysql -u$user -p$pass -h $DBADA_DEV -e "DROP DATABASE IF EXISTS $DBNAME"

#Create database adapters
#mysqladmin -u$user -p$pass -h $DBADA_DEV create databasename $DBNAME
mysql -u$user -p$pass -h $DBADA_DEV -e "CREATE DATABASE IF NOT EXISTS $DBNAME"

# Import
mysql -u$user -p$pass -h $DBADA_DEV --debug-info --progress-reports $DBNAME < $DBNAME.sql
