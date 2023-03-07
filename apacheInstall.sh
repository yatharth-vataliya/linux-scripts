echo "Adding necessary PPA for Apache2 server.";

add-apt-repository -y ppa:ondrej/apache2;
apt update;
apt install -y apache2;

echo "Apache is installed successfully.";

apache2 -V;