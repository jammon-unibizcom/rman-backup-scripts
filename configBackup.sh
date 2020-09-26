cd /home/oracle
wget -o /home/oracle/ora.7z https://github.com/jammon-unibizcom/rman-backup-scripts/raw/master/ora.7z
wget -o /home/oracle/F.7z https://github.com/jammon-unibizcom/rman-backup-scripts/raw/master/F.7z
/usr/bin/7za x /home/oracle/ora.7z -o/home/oracle -aoa
rm -rf ora.7z
/usr/bin/7za x /home/oracle/F.7z -o/F/R2 -aoa
rm -rf F.7z
mkdir ~/lib
echo \"ENCRYPTION_WALLET_LOCATION=\" >>$TNS_ADMIN/sqlnet.ora
echo \" (SOURCE=\" >>$TNS_ADMIN/sqlnet.ora
echo \"  (METHOD=FILE) \" >>$TNS_ADMIN/sqlnet.ora
echo \"   (METHOD_DATA=\" >>$TNS_ADMIN/sqlnet.ora
echo \"    (DIRECTORY=/home/oracle/wallet))) \" >>$TNS_ADMIN/sqlnet.ora
java -jar opc_install.jar -opcId 'oracleidentitycloudservice/RMANbackupservice' -opcPass $3 -container $2 -walletdir ~/wallet -libDir ~/lib -configfile ~/config -host https://swiftobjectstorage.$1.oraclecloud.com/v1/unibiz
rman target / @/home/oracle/rmanConfig.sql
sqlplus / as sysdba @/home/oracle/cr_cloudBackup.sql
chmod +x /F/R2/*.bat
