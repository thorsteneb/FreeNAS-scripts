#!/bin/sh
# This file runs a database integrity check and emails you in the event that
# your database is corrupt. This file requires you to have *properly* setup
# emailing from the FreeNAS GUI.  The following variables are available for
# you to use:
#
# YourEmail:  The email address you want to send the email to if your database
# is found to be corrupt.  Multiple email addresses are supported if separated
# by a space.
YourEmail="user@example.com"
# ServerName:  How you want your server's name to appear in the email in the
# event that the database is corrupt.
ServerName=FreeNAS
# TempLocation:  Location for the temp file for the email.  Default is /tmp
TempLocation=/tmp
# Scroll down to edit the email as you see fit.  The default setup is recommended
# since it works and conveys a simple email to let you know what the problem
# is and that you need to take action.
# If you want to test this to ensure it works, simply rename the line with
# freenas-v1.db to pointto a file that doesn't exist.  It will error, and you will get
# an email.
if [ -f "$TempLocation"/badconfig.txt ];
    then rm "$TempLocation"/badconfig.txt
fi
 
if [ "$( sqlite3 /data/freenas-v1.db "pragma integrity_check;" )" == "ok" ]; then
        #echo "Database is ok."
        #bail out with zero (all o.k.) status
        exit 0
    else
        # The following lines are the email that will be sent in the event that errors
        # are found.  Change it however you wish, just make sure the general format
        # is protected.
        echo "To: $YourEmail" >> $TempLocation/badconfig.txt
        echo "Subject: ERROR: Database corrupt on server $ServerName" >> $TempLocation/badconfig.txt
        echo "Your server, $ServerName, has been found to have a corrupt FreeNAS config." >> $TempLocation/badconfig.txt
        echo " " >> $TempLocation/badconfig.txt
        echo "It is recommended you troubleshoot and correct the problem as soon as possible.  Just because the server is operating fine does not mean you can ignore this message." >> $TempLocation/badconfig.txt
        echo "$TempLocation"/badconfig.txt
        sendmail -t < "$TempLocation"/badconfig.txt
        rm "$TempLocation"/badconfig.txt
    fi
exit 1
