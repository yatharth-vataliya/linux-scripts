
function restartApache() {
    sudo systemctl restart apache2;
}

sudo systemctl disable $0;
sudo systemctl stop $0;
restartApache2();
sudo a2enmod $1;
restartApache2();
sudo a2enconf
