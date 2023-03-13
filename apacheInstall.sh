echo "Adding necessary PPA for Apache2 server.";
systemType=$(awk -F= '/^ID/{print $2}' /etc/os-release);
if [ $systemType == "debian" ];
then
curl -sSLo /usr/share/keyrings/deb.sury.org-apache2.gpg https://packages.sury.org/apache2/apt.gpg;
sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-apache2.gpg] https://packages.sury.org/apache2/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/apache2.list';
apt-get update;
elif [ $systemType == "ubuntu" ];
then
add-apt-repository -y ppa:ondrej/apache2;
apt update;
fi;

apt install -y apache2;
echo "Apache is installed successfully.";

apache2 -V;