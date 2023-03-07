echo "Adding necessary PPA for Git.";

add-apt-repository -y ppa:git-core/ppa;
apt update;
apt install -y git;

echo "Git installed successfully.";

git --version;