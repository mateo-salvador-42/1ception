FROM debian:12

RUN apt update
RUN apt install php-fpm php-json php-mysqli mariadb-client curl -y
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
COPY tools/script.sh /usr/local/bin/
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
RUN chmod +x /usr/local/bin/script.sh
EXPOSE 9000
ENTRYPOINT ["/usr/local/bin/script.sh"]
