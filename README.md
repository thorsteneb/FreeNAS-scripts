# FreeNAS-scripts
Scripts to back up configuration data daily. Set variables inside for your backup location. Set a cloud sync task to get the backup off your pool.

Copy the scripts to /root/scripts via scp (enable ssh first), and chmod +x them so they are executable.

In FreeNAS, choose Tasks, cron jobs, and create a new cron job:
- Command: /root/scripts/checkconfigdb.sh && /root/scripts/backupconfigdb.sh
- Run as user: root
- Schedule cron job: Daily
- Hide standard output, hide standard error and enabled: Checked
