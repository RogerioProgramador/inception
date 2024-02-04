all:	servername
	sudo mkdir -p /home/rsiqueir/data/mariadb_vol
	sudo mkdir -p /home/rsiqueir/data/wordpress_vol
	sudo docker-compose -f srcs/docker-compose.yml up --build --force-recreate --no-deps

servername:
	grep -q '127.0.0.1 localhost rsiqueir.42.fr' /etc/hosts || sudo sh -c "echo '127.0.0.1 localhost rsiqueir.42.fr' >> /etc/hosts"

clean:
	sudo rm -rf /home/rsiqueir/data/mariadb_vol
	sudo rm -rf /home/rsiqueir/data/wordpress_vol
	sudo sed -i '/127.0.0.1 localhost rsiqueir.42.fr/d' /etc/hosts
