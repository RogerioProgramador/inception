# Imagem base
FROM debian:bullseye

#realizando update e upgrade(se necessario) das dependencias
RUN apt update && apt upgrade

#instalando o nginx
RUN apt install nginx -y

#instalando o OpenSSL para criacao do certificado
RUN apt install openssl -y

#pasta para guardar a key para a conexao segura
RUN mkdir -p /etc/nginx/ssl

#Criando o certificado
RUN openssl req \
    -x509 \ 
    -nodes \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=BR/ST=Sao Paulo/L=Sao Paulo/O=42/OU=Inception/CN=rsiqueir.42.fr"

#Criando a pasta para guardar a config file do Nginx. PRECISA??
RUN mkdir -p /var/run/nginx

#Copiando o arquivo config do diretorio raiz para dentro do container
COPY conf/nginx.conf /etc/nginx/conf.d/

# Expor portas
EXPOSE 80 443

# Executar o Nginx ao iniciar o container
CMD [ "nginx", "-g", "daemon off;"]
