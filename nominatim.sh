sudo apt update -qq

sudo apt install -y php-cgi
sudo apt install -y build-essential cmake g++ libboost-dev libboost-system-dev \
                    libboost-filesystem-dev libexpat1-dev zlib1g-dev \
                    libbz2-dev libpq-dev liblua5.3-dev lua5.3 \
                    postgresql-server-dev-14 postgresql-14-postgis-3 \
                    postgresql-contrib-14 postgresql-14-postgis-3-scripts \
                    php-cli php-pgsql php-intl libicu-dev python3-dotenv \
                    python3-psycopg2 python3-psutil python3-jinja2 \
                    python3-icu python3-datrie

sudo useradd -d /srv/nominatim -s /bin/bash -m nominatim

export USERNAME=nominatim
export USERHOME=/srv/nominatim

chmod a+x $USERHOME

sudo systemctl restart postgresql

sudo -u postgres createuser -s $USERNAME
sudo -u postgres createuser www-data

cd $USERHOME
wget https://nominatim.org/release/Nominatim-4.2.3.tar.bz2
tar xf Nominatim-4.2.3.tar.bz2

mkdir $USERHOME/build
cd $USERHOME/build
cmake $USERHOME/Nominatim-4.2.3
make
sudo make install

mkdir $USERHOME/nominatim-project
mkdir $USERHOME/nominatim-project/website

sudo apt install -y apache2 libapache2-mod-php

sudo tee /etc/apache2/conf-available/nominatim.conf << EOFAPACHECONF
<Directory "$USERHOME/nominatim-project/website">
  Options FollowSymLinks MultiViews
  AddType text/html   .php
  DirectoryIndex search.php
  Require all granted
</Directory>

Alias /nominatim $USERHOME/nominatim-project/website
EOFAPACHECONF

sudo a2enconf nominatim

sudo systemctl restart apache2

mkdir ~/nominatim-planet
cd ~/nominatim-planet

export PROJECT_DIR=~/nominatim-planet

cd $PROJECT_DIR
wget https://nominatim.org/data/wikimedia-importance.sql.gz

wget https://download.geofabrik.de/europe/france/martinique-latest.osm.pbf

nominatim import --osm-file martinique-latest.osm.pbf 2>&1 | tee setup.log