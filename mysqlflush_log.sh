#!/bin/bash

# mysql data backup script
# use mysqldump --help,get more detail.
#

BakDir=/home/nieys/mysqlbackup/mysql/
LogFile=/home/nieys/mysqlbackup/mysql/mysqlbak.log

DATE=`date +%Y%m%d`

echo " " >> $LogFile
echo " " >> $LogFile
echo "--------------------------" >> $LogFile
echo $(date +"%y-%m-%d %H:%M:%S") >> $LogFile
echo "--------------------------" >> $LogFile


cd $BakDir

DumpFile=$DATE.sql
GZDumpFile=$DATE.sql.tgz

mysqldump -utdrhtest -ptdrhEDU123 --quick --all-databases --flush-logs \
#mysqldump -uroot -ptdrhedu --quick --all-databases --flush-logs \
  --flush-privileges --lock-all-tables  > $DumpFile

echo "Dump Done" >> $LogFile

tar czf $GZDumpFile $DumpFile -C $BakDir  

echo "[$GZDumpFile]Backup Success!" >> $LogFile

rm -f $DumpFile
        find ./ -type f -mtime +7 -exec rm -f {} \;
