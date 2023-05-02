# wget https://download2.rstudio.org/server/centos7/x86_64/rstudio-server-rhel-2023.03.0-386-x86_64.rpm
echo "deb http://security.ubuntu.com/ubuntu focal-security main" | sudo tee /etc/apt/sources.list.d/focal-security.list

sudo apt-get update
sudo apt-get install libssl1.1
sudo rm /etc/apt/sources.list.d/focal-security.list
sudo apt-get install r-base
sudo apt-get install gdebi-core
# wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-2023.03.0-386-amd64.deb
sudo gdebi rstudio-server-2023.03.0-386-amd64.deb