sudo yum -y install java p7zip
sudo su oracle sh -c "cd /home/oracle ; wget https://github.com/jammon-unibizcom/rman-backup-scripts/raw/master/configBackup.sh ; chmod +x /home/oracle/configBackup.sh ; /home/oracle/configBackup.sh $1 $2 $3"
sudo systemctl stop crond.service
sudo mv /etc/crontab /etc/crontab.bak
sudo su -c "cat /etc/crontab.bak | grep -v \.bat >/etc/crontab"
sudo su -c "echo 30 23 \* \* \* oracle /F/R2/r2hotbackup.bat >>/etc/crontab"
sudo su -c "echo */20 \* \* \* \* oracle /F/R2/rman_cloud_archivelog.bat >>/etc/crontab"
sudo su -c "echo 00 01 \* \* sun,wed oracle /F/R2/analyze.bat >>/etc/crontab"
sudo su -c "chmod 644 /etc/crontab"
sudo su -c "semanage fcontext -a -t system_cron_spool_t \"/etc/crontab\""
sudo su -c "restorcon -RFv /etc/crontab"
sudo su -c "sudo systemctl start crond.service"

rm -rf /home/opc/setupBackup.sh

