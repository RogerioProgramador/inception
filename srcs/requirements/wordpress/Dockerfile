# Imagem base
FROM debian:bullseye

# Realizando update e upgrade(se necessario) das dependencias
RUN apt update && apt upgrade

# Para instalar o wordpress sera necessario fazer um download, portanto o wget e necessario.
RUN apt-get -y install wget

# Instalando o PHP e as dependencias necessarias
RUN apt-get install -y \ 
    php7.4\
    php-fpm\
    php-mysql\
    mariadb-client

# Copiando o arquivo de configuracao padrao para o php fpm
COPY conf/www.conf /etc/php/7.4/fpm/pool.d

# Fazer o download do Wordpress e o disponibilizando na pasta /var/www
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www

# Entrando na pasta e realizando a descompatacao
RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz

# Baixando CLI do Wordpress responsavel pela instalacao
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    --output-document=/usr/local/bin/wp \
    && chmod +x /usr/local/bin/wp

# Passando o Script para dentro do container
COPY tools/init.sh /usr/local/bin/init.sh

# Concedendo as permissoes necessarias
RUN chmod +x /usr/local/bin/init.sh

# Cria o diretorio que o php-fpm vai guardar o arquivo do PID
RUN mkdir -p /run/php

# Expor porta
EXPOSE 9000

#Rodar o Script
ENTRYPOINT [ "init.sh" ]

# Rodar o php-fpm
CMD ["/usr/sbin/php-fpm7.4", "-F"]