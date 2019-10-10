#! /bin/bash

#### USAGE ####
# ./make_backup current_database name_of_backup
##############

# Get timestampe for naming backup
orig=$(date)
epoch=$(date -d "${orig}" +"%s")
dt=$(date -d @$epoch +%Y%m%d)

current_db=$1
new_backup=/data/backups/$2_$dt
mysql_path=/var/lib/mysql

/etc/init.d/mysql stop

mkdir $new_backup

cp $mysql_path/ib_buffer_pool $new_backup
cp $mysql_path/ibdata1 $new_backup
cp $mysql_path/ib_logfile0 $new_backup
cp $mysql_path/ib_logfile1 $new_backup
cp $mysql_path/ibtmp1 $new_backup
cp -R $mysql_path/mysql $new_backup
cp -R $mysql_path/$1 $new_backup

chown -R mysql:mysql $new_backup

/etc/init.d/mysql start
echo `date` " made $new_backup" >> db_history.log
