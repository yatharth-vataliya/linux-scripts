COLOUR_RED="\e[31m";
COLOUR_GREEN="\e[32m";
NO_COLOUR="\e[0m";

uid=$(id -u);
if [ $uid -ne 0 ];
then
    echo -e "${COLOUR_RED}Hey there this is script for installing some software on ubuntu system\nand this script need sudo permission to install everything so\nmake sure you have root level permissions.${NO_COLOUR}";
    exit;
fi;

apt-get -y install lsb-release ca-certificates curl;
apt install wget -y;
SYSTEMTYPE=$(lsb_release -si);

echo "This is script for installing web development software on Debian/Ubuntu system";

options=("All" "Apache2" "PHP" "Composer" "NodeJS" "MySql" "Git");

function main(){

echo -e "\n";
echo -e "${COLOUR_RED}Please select any option :-
1 Apache2
2 PHP
3 Composer
4 NodeJS
5 MySql
6 Git
0 All
${NO_COLOUR}";

read selectedOption;

case $selectedOption in
    0) installAll ;;
    1) installApache ;;
    2) installPHP ;;
    3) installComposer ;;
    4) installNodeJS ;;
    5) installMySql ;;
    6) installGit ;;
    *)
        echo -e "${COLOUR_RED}Please select proper option between 0 to 6${NO_COLOUR}";
        main
        ;;
esac;
}

function installAll(){
    installApache;
    installPHP;
    installComposer;
    installNodeJS;
    installMySql;
    installGit;
}

function installApache(){
    echo -e "\n${COLOUR_RED}Adding necessary PPA for Apache2 server.${NO_COLOUR}\n";
    if [ $SYSTEMTYPE == "Debian" ];
    then
        curl -sSLo /usr/share/keyrings/deb.sury.org-apache2.gpg https://packages.sury.org/apache2/apt.gpg;
        sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-apache2.gpg] https://packages.sury.org/apache2/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/apache2.list';
        apt-get update;
    elif [ $SYSTEMTYPE == "Ubuntu" ];
    then
        add-apt-repository -y ppa:ondrej/apache2;
        apt update;
    fi;

    apt install -y apache2;
    echo -e "\n${COLOUR_GREEN}Apache is installed successfully.${NO_COLOUR}\n";
    apache2 -V;
}
function installPHP(){
    echo -e "\n${COLOUR_RED}Adding necessary PPA for PHP.${NO_COLOUR}\n";

    if [ $SYSTEMTYPE == "Debian" ];
    then
        curl -sSLo /usr/share/keyrings/deb.sury.org-php.gpg https://packages.sury.org/php/apt.gpg
        sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
        apt-get update
    elif [ $SYSTEMTYPE == "Ubuntu" ];
    then
        add-apt-repository -y ppa:ondrej/php;
        apt update;
    fi;

    read -p "Please give specific version of PHP. For example 7.4 or 8.2 :- " phpVersion;
    echo -e "\n${COLOUR_GREEN}Installing php version php$phpVersion${NO_COLOUR}\n";
    apt install -y php$phpVersion-fpm php$phpVersion-intl php$phpVersion-xml php$phpVersion-mysql php$phpVersion-mbstring php$phpVersion-zip php$phpVersion-imagick php$phpVersion-xdebug php$phpVersion-uuid php$phpVersion-bcmath php$phpVersion-bz2 \
    php$phpVersion-gd php$phpVersion-redis php$phpVersion-curl libapache2-mod-php$phpVersion;
    echo -e "\n${COLOUR_GREEN}PHP version $phpVersion successfully installed.${NO_COLOUR}\n";
    php --version;
}
function installComposer(){
    echo -e "\n${COLOUR_GREEN}Installing composer${NO_COLOUR}\n";

    if [ -h /usr/bin/php ]; then
        php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');";
        php composer-setup.php;
        php -r "unlink('composer-setup.php');";
        mv composer.phar /usr/local/bin/composer
    else
        echo -e "\n${COLOUR_RED}PHP is not installed please install PHP first.${NO_COLOUR}\n";
        exit;
    fi;
}
function installNodeJS(){
    echo -e "\n${COLOUR_RED}Adding necessary PPA for nodejs.${NO_COLOUR}\n";
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && apt-get install -y nodejs;
    echo -e "\n${COLOUR_GREEN}nodejs installed successfully.${NO_COLOUR}\n";
    node --version;
    npm --version;
}
function installMySql(){
    echo -e "\nInstalling MySql Server.\n";

    if [ $SYSTEMTYPE == "Debian" ];
    then
    wget https://dev.mysql.com/get/mysql-apt-config_0.8.20-1_all.deb
    apt install ./mysql-apt-config_*_all.deb
    fi;

    apt update

    declare -a keyservers=(
        "hkp://keyserver.ubuntu.com:80"
        "keyserver.ubuntu.com"
        "ha.pool.sks-keyservers.net"
        "hkp://ha.pool.sks-keyservers.net:80"
        "p80.pool.sks-keyservers.net"
        "hkp://p80.pool.sks-keyservers.net:80"
        "pgp.mit.edu"
        "hkp://pgp.mit.edu:80"
    )

    keys=$(apt update 2>&1 | grep -o '[0-9A-Z]\{16\}$')

    for key in $keys; do
        for server in "${keyservers[@]}"; do
            echo -e "${COLOUR_RED}Fetching GPG key ${key} from ${server}${NO_COLOUR}"
            apt-key adv --keyserver $server --keyserver-options timeout=10 --recv-keys ${key}
            if [ $? -eq 0 ]; then
                echo -e "${COLOUR_GREEN}Key '${key}' successful added from server '${server}'${NO_COLOUR}"
                break
            else
                echo -e "${COLOUR_RED}Failed add key '${key}' from server '${server}'. Try another server${NO_COLOUR}"
                continue
            fi
        done
    done

    apt install -y mysql-server;

    echo -e "\n${COLOUR_GREEN}MySql is installed successfully.${NO_COLOUR}\n";

    mysql -V;
    systemctl enable --now mysql;
    rm mysql-apt-config_*_all.deb;
}
function installGit(){
    echo -e "\nInstalling Git .\n";
    if [ $SYSTEMTYPE == "Ubuntu" ];
    then
        echo -e "\n${COLOUR_RED}Adding necessary PPA for Git.${NO_COLOUR}\n";
        add-apt-repository -y ppa:git-core/ppa;
        apt update;
    fi;
    apt install -y git;
    echo -e "\n${COLOUR_GREEN}Git installed successfully.${NO_COLOUR}\n";
    git --version;
}
main;