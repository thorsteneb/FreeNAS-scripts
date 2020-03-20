#!/bin/sh
# This file backs up your FreeNAS configuration database and keeps it for N days
#
# Location to store backup files in, adjust this to your dataset and path
# Note this path has to end with '/'
BackupDir=/mnt/MYPOOL/Backup/FreeNAS-config/
# Number of days to keep backups for
KeepFor=60
#
# /etc/version in format 'FreeNAS-11.3-RELEASE (c0e049a7fa)'; use cut to extract 11.3_RELEASE 
cp /data/freenas-v1.db $BackupDir`date +%Y%m%d`_`cat /etc/version | cut -d'-' -f2`_`cat /etc/version | cut -d'-' -f3 | cut -d' ' -f1`.db
find $BackupDir -type f -depth 1 -mtime +$KeepFor -delete
