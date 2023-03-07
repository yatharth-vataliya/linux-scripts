echo "Adding necessary PPA for nodejs.";

apt install -y curl;

curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && apt-get install -y nodejs;

echo "nodejs installed successfully.";

node --version;
npm --version;