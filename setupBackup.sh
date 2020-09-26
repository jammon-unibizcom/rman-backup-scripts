sudo yum -y install java p7zip
sudo su oracle sh -c "cd /home/oracle ; wget -o /home/oracle/setupBackup.sh https://github.com/jammon-unibizcom/rman-backup-scripts/raw/master/setupBackup.sh ; chmod +x /home/oracle/setupBackup.sh ; /home/oracle/setupBackup.sh $1 $2 $3"
sudo systemctl stop crond.service
sudo mv /etc/crontab /etc/crontab.bak
sudo su -c "echo 30 23 \* \* \* oracle /F/R2/r2hotbackup.bat >>/etc/crontab"
sudo su -c "echo */20 \* \* \* \* oracle /F/R2/rman_cloud_archivelog.bat >>/etc/crontab"
sudo su -c "echo 00 01 \* \* sun,wed oracle /F/R2/analyze.bat >>/etc/crontab"
sudo systemctl start crond.service

rm -rf /home/opc/setupBackup.sh

