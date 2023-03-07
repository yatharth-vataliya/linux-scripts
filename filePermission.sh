# This is file permisson for laravel project.
# you have to give two arguments when running from terminal
# 1. your user name
# 2. your web server's user name
chown -R $1:$2 .
find . -type d -exec chmod 0755 {} \;
find . -type f -exec chmod 0644 {} \;
chmod -R ug+rwx bootstrap/cache/ storage/
