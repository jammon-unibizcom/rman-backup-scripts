sudo yum -y install java p7zip
sudo su oracle sh -c "cd /home/oracle ; wget https://github.com/jammon-unibizcom/rman-backup-scripts/raw/master/configBackup.sh ; chmod +x /home/oracle/configBackup.sh ; /home/oracle/configBackup.sh $1 $2 $3 $4 $5"
sudo su -c "wget https://github.com/jammon-unibizcom/rman-backup-scripts/raw/master/newcrontab ; cat /home/opc/newcrontab > /etc/crontab ; systemctl restart crond.service ; rm -rf /home/opc/newcrontab"
rm -rf /home/opc/setupBackup.sh
