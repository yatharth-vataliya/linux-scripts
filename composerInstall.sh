echo "Installing composer";

if [ -h /usr/bin/php ]; then
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');";
php composer-setup.php;
php -r "unlink('composer-setup.php');";
mv composer.phar /usr/local/bin/composer
echo "Everything looks good";
else
echo "PHP is not installed please install PHP first.";
exit;
fi;
