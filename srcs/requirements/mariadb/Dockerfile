# Imagem base
FROM debian:bullseye

#realizando update e upgrade(se necessario) das dependencias
RUN apt update && apt upgrade

#Instalando mariadb
RUN apt-get install mariadb-server -y

#Modificando o arquivo de configuracao sobrescrevendo com o nosso
COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

# Iniciando o servico
RUN service mariadb start

# PRECISA ALTERAR A SENHA DO ROOT?
RUN mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;" \
    mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';" \
    mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';" \
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';" \
    mysql -e "FLUSH PRIVILEGES;"

# REINICIANDO PARA TODAS AS MUDANCAS TEREM EFEITO
RUN mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

CMD ["mysqld_safe"]