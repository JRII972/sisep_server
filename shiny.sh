sudo su - \ -c "R -e \"install.packages('shiny', repos='https://cran.rstudio.com/')\""
sudo apt-get install gdebi-core
sudo gdebi shiny-server-1.5.20.1002-amd64.deb