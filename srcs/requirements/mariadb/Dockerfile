FROM debian:12

RUN apt update
RUN apt -y install mariadb-server
COPY tools/db.sh /usr/local/bin/db.sh
EXPOSE 3306
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chmod +x /usr/local/bin/db.sh
ENTRYPOINT ["/usr/local/bin/db.sh"]
