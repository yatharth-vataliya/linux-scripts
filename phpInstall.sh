
echo "Adding necessary PPA for PHP.";

add-apt-repository -y ppa:ondrej/php;
apt update;

echo "Installing php version php$1";

apt install -y php$1-fpm php$1-intl php$1-xml php$1-mysql php$1-mbstring php$1-zip php$1-imagick php$1-xdebug php$1-uuid php$1-bcmath php$1-bz2 \
php$1-gd php$1-redis php$1-curl libapache2-mod-php$1;

php --version;
