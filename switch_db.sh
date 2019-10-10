#! /bin/bash
#### USAGE ####
# ./switch_db name_of_database name_of_copy

/etc/init.d/mysql stop

rm -rf /var/lib/mysql/$1
cp -Rf /data/backups/$2/* /var/lib/mysql
chown -R mysql:mysql /var/lib/mysql
echo `date`     "Switched to $2" >> db_history.log
/etc/init.d/mysql start

