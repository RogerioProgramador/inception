#!/bin/sh

set -x
sleep 20

# Mudar para o diretório do WordPress
cd /var/www/wordpress

# Configuracao do banco de dados
if [ -e wp-config.php ]; then
      echo "Wordpress config already created"
else
    wp config create --allow-root \
        --dbname=$SQL_NAME \
        --dbuser=$SQL_USER \
        --dbpass=$SQL_PASSWORD \
        --dbhost=$SQL_HOSTNAME

    chmod 600 wp-config.php
fi

# Configuracao da Criacao de usuarios Root e Padrao
if wp core is-installed --allow-root; then
      echo "Wordpress core already installed"
else

    wp core install --allow-root \
        --url=$DOMAIN_NAME \
        --title=$WP_TITLE \
        --admin_user=$WP_ADMIN_USR \
        --admin_email=$WP_ADMIN_EMAIL \
        --admin_password=$WP_ADMIN_PWD

    wp user create --allow-root \
        $WP_USR \
        $WP_EMAIL \
        --role=author \
        --user_pass=$WP_PWD

    wp config set WORDPRESS_DEBUG false --allow-root
fi

# Instalar e mudar o idioma para inglês
wp language core install en_US --allow-root
wp site switch-language en_US --allow-root

sed -ie 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 0.0.0.0:9000/g' \
/etc/php/7.4/fpm/pool.d/www.conf

chown -R www-data:www-data /var/www/*

exec "$@"