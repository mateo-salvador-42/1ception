*This activity has been created as part of the 42 curriculum by masalvad.*

# Inception

## Description

Inception is a system administration project from the 42 curriculum. The goal is to set up a small infrastructure composed of multiple services using Docker and Docker Compose inside a virtual machine.

The stack consists of three containers: NGINX (as the sole entry point over HTTPS), WordPress with php-fpm, and MariaDB. All services communicate through a dedicated Docker network, and data is persisted using Docker volumes.

## Instructions

### Prerequisites

- A virtual machine running Debian 12
- Docker and Docker Compose installed
- `make` installed

### Setup

1. Clone the repository:
```bash
git clone <your-repo-url>
cd inception
```

2. Create the `secrets/` directory at the root with the following files:
```bash
mkdir secrets
echo "your_db_password" > secrets/db_password.txt
echo "your_db_root_password" > secrets/db_root_password.txt
echo "your_wp_admin_password" > secrets/wp_password.txt
```

3. Fill in `srcs/.env` with your values:
```
DOMAIN_NAME=masalvad.42.fr
MYSQL_DATABASE=inception
MYSQL_USER=masalvad
```

4. Add your domain to `/etc/hosts`:
```
127.0.1.1    masalvad.42.fr
```

5. Build and start the project:
```bash
make
```

6. Access the WordPress site at: `https://masalvad.42.fr`

### Makefile commands

- `make` / `make all` — Build images and start containers
- `make down` — Stop and remove containers
- `make clean` — Remove containers, images, and volumes
- `make re` — Full rebuild from scratch

## Project Description

### Docker usage

This project uses Docker Compose to orchestrate three services: NGINX handles HTTPS termination and forwards PHP requests to WordPress via FastCGI on port 9000. WordPress runs php-fpm without a web server. MariaDB stores the WordPress database. All three communicate through a custom bridge network.

### Virtual Machines vs Docker

Virtual machines emulate an entire hardware environment and run a full OS, making them heavier and slower to start. Docker containers share the host kernel and isolate only the process and its dependencies, making them lightweight, fast, and portable. VMs offer stronger isolation; Docker offers efficiency.

### Secrets vs Environment Variables

Environment variables (`.env`) are readable by anyone with access to the host filesystem or Docker inspect. Docker secrets are mounted as files inside containers at `/run/secrets/` and are only accessible to the containers that explicitly request them. Secrets are preferred for sensitive data like passwords.

### Docker Network vs Host Network

With a Docker network (bridge), containers are isolated in their own virtual network and communicate using service names as hostnames. With host networking, containers share the host's network stack directly, which removes isolation and can cause port conflicts. Bridge networking is safer and is required by this project (host networking is explicitly forbidden).

### Docker Volumes vs Bind Mounts

Docker volumes are managed by Docker and stored in Docker's internal storage (`/var/lib/docker/volumes/`). Bind mounts map a specific host path into the container. Volumes are more portable and easier to back up, while bind mounts give direct access to host files. This project uses named volumes for data persistence.

## Resources

- [Docker documentation](https://docs.docker.com)
- [Docker Compose documentation](https://docs.docker.com/compose/)
- [NGINX documentation](https://nginx.org/en/docs/)
- [WordPress CLI (wp-cli)](https://wp-cli.org/)
- [MariaDB documentation](https://mariadb.com/kb/en/)
- [php-fpm configuration](https://www.php.net/manual/en/install.fpm.configuration.php)
- [PID 1 and Docker best practices](https://cloud.google.com/architecture/best-practices-for-building-containers)

### AI usage

AI (Claude) was used to assist with debugging configuration issues (php-fpm pool settings, MariaDB bind-address, Docker secrets path), understanding Docker concepts (volumes, networks, secrets), and reviewing Dockerfile best practices. All generated content was reviewed, tested, and adapted manually.
# 1nception
# 1nception
# 1nception
# 1nception
# 1nception
