#!/bin/bash

# Iniciando o serviço do MariaDB temporariamente
service mariadb start

# Espera um pouco para o serviço iniciar completamente
sleep 10

# Executando os comandos SQL
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"

# Parando o serviço MariaDB para que o CMD possa iniciar normalmente
mysqladmin -u root -p"$SQL_ROOT_PASSWORD" shutdown

# Mantendo o contêiner rodando
mysqld_safe
