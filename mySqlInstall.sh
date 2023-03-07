echo "Installing MySql Server with Native Ubuntu release archive.";

apt install -y mysql-server;

echo "MySql is installed successfully.";

mysql -V;