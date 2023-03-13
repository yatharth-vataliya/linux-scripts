uid=$(id -u);
if [ $uid -ne 0 ];
then
echo "Hey there this is script for installing some software on ubuntu system
and this script need sudo permission to install everything so
make sure you have root level permissions";
exit;
fi;

systemType=$(awk -F= '/^ID/{print $2}' /etc/os-release);

apt-get -y install lsb-release ca-certificates curl;
apt install wget -y;

bash apacheInstall.sh;
bash phpInstall.sh 8.2;
bash composerInstall.sh;
bash nodejsInstall.sh;
bash mySqlInstall.sh;
bash gitInstall.sh;