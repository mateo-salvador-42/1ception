FROM debian:12

RUN apt update
RUN apt install openssl nginx -y
RUN mkdir -p /etc/nginx/ssl/
RUN openssl genpkey -algorithm RSA -out /etc/nginx/ssl/key.pem -pkeyopt rsa_keygen_bits:2048
RUN openssl req -x509 -newkey rsa:2048 -keyout /etc/nginx/ssl/key.pem -out /etc/nginx/ssl/cert.pem -days 365 -nodes -subj "/C=FR/ST=Marseille/L=Marseille/O=42/CN=masalvad.42.fr"
COPY conf/nginx.conf /etc/nginx/conf.d/nginx.conf
EXPOSE 443
ENTRYPOINT ["nginx","-g","daemon off;"]
