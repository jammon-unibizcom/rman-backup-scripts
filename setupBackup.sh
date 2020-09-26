sudo yum -y install java p7zip
sudo su oracle sh -c "cd ~ ; wget https://github.com/jammon-unibizcom/rman-backup-scripts/blob/master/ora.7z ; wget https://github.com/jammon-unibizcom/rman-backup-scripts/blob/master/ora.7z ; 7za x ora.7z ; rm -rf ora.7z ; 7za x F.7z /F/R2 ; rm -rf F.7z ; mkdir ~/lib ; echo \"ENCRYPTION_WALLET_LOCATION=\" >>$TNS_ADMIN/sqlnet.ora ; echo \" (SOURCE=\" >>$TNS_ADMIN/sqlnet.ora ; echo \"  (METHOD=FILE) \" >>$TNS_ADMIN/sqlnet.ora ; echo \"   (METHOD_DATA=\" >>$TNS_ADMIN/sqlnet.ora ; echo \"    (DIRECTORY=/home/oracle/wallet))) \" >>$TNS_ADMIN/sqlnet.ora" ; java -jar opc_install.jar -opcId 'oracleidentitycloudservice/RMANbackupservice' -opcPass $3 -container $2 -walletdir ~/wallet -libDir ~/lib -configfile ~/config -host https://swiftobjectstorage.$1.oraclecloud.com/v1/unibiz ; rman target / @/home/oracle/rmanConfig.sql ; sqlplus / as sysdba @/home/oracle/cr_cloudBackup.sql ; chmod +x /F/R2/*.bat
sudo systemctl stop crond.service
sudo mv /etc/crontab /etc/crontab.bak
sudo su -c "echo 30 23 \* \* \* oracle /F/R2/r2hotbackup.bat >>/etc/crontab"
sudo su -c "echo */20 \* \* \* \* oracle /F/R2/rman_cloud_archivelog.bat >>/etc/crontab"
sudo su -c "echo 00 01 \* \* sun,wed oracle /F/R2/analyze.bat >>/etc/crontab"
sudo systemctl start crond.service

rm -rf /home/opc/setupBackup.sh

