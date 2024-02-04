# Imagem base
FROM debian:bullseye

# Realizando update e upgrade(se necessario) das dependencias
RUN apt update && apt upgrade -y

# Instalando mariadb
RUN apt-get install mariadb-server -y

#Modificando o arquivo de configuracao sobrescrevendo com o nosso
COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

# Copiando o script de inicialização
COPY tools/init-db.sh /usr/local/bin/init-db.sh
RUN chmod +x /usr/local/bin/init-db.sh

# Expor portas
EXPOSE 3306

CMD ["/usr/local/bin/init-db.sh"]