
echo "Adding necessary PPA for PHP.";
systemType=$(awk -F= '/^ID/{print $2}' /etc/os-release);
if [ $systemType == "debian" ];
then
echo "you are currently using Debian system";
curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg
sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
apt-get update
elif [ $systemType == "ubuntu" ];
then
echo "you are currenlty using Ubuntu system";
add-apt-repository -y ppa:ondrej/php;
apt update;
fi;

echo "Installing php version php$1";

apt install -y php$1-fpm php$1-intl php$1-xml php$1-mysql php$1-mbstring php$1-zip php$1-imagick php$1-xdebug php$1-uuid php$1-bcmath php$1-bz2 \
php$1-gd php$1-redis php$1-curl libapache2-mod-php$1;

php --version;
