echo "Adding necessary PPA for Git.";
systemType=$(awk -F= '/^ID/{print $2}' /etc/os-release);
if [ $systemType == "ubuntu" ];
then
add-apt-repository -y ppa:git-core/ppa;
apt update;
fi;

apt install -y git;

echo "Git installed successfully.";

git --version;