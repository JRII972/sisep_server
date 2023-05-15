cd ~

sudo apt install nginx redis-server
sudo apt install openjdk-jdk

bench init daaf-bench

cd daaf-bench

sudo bench setup production

bench set-config -g db_host mariadb
bench set-config -g redis_cache redis://redis-cache:6379
bench set-config -g redis_queue redis://redis-queue:6379
bench set-config -g redis_socketio redis://redis-socketio:6379

bench new-site sisep.daaf --db-name daaf_bench --mariadb-root-password 123 --admin-password admin 

bench --site sisep.daaf set-config developer_mode 1
bench --site sisep.daaf clear-cache

bench get-app https://github.com/frappe/wiki
bench get-app https://github.com/frappe/insights --branch main
bench get-app https://github.com/JRII972/daaf 

bench --site daaf.localhost install-app wiki insights daaf

bench start
