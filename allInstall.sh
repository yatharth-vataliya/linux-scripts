uid=$(id -u);
if [ $uid -ne 0 ];
then
echo "Hey there this is script for installing some software on ubuntu system
and this script need sudo permission to install everything so
make sure you have root level permissions";
exit;
fi;

echo "just test";