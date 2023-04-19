sudo apt install git python-dev python-pip redis-server
apt-get install mariadb-client-10.3
# nano /etc/mysql/my.cnf

echo "" >> /etc/mysql/my.cnf
echo "[mysqld]" >> /etc/mysql/my.cnf
echo "character-set-client-handshake = FALSE" >> /etc/mysql/my.cnf
echo "character-set-server = utf8mb4" >> /etc/mysql/my.cnf
echo "collation-server = utf8mb4_unicode_ci" >> /etc/mysql/my.cnf
echo "" >> /etc/mysql/my.cnf
echo "[mysql]" >> /etc/mysql/my.cnf
echo "default-character-set = utf8mb4" >> /etc/mysql/my.cnf

service mysql restart

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

nvm install 14

npm install -g yarn

apt-get install xvfb libfontconfig wkhtmltopdf

pip3 install frappe-bench