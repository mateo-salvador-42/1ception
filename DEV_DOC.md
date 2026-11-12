# DEV_DOC — Developer Documentation

## Setting up the environment from scratch

### Prerequisites

- Debian 12 virtual machine (VirtualBox or equivalent)
- Docker installed: `sudo apt install docker.io -y`
- Docker Compose installed: `sudo apt install docker-compose-v2 -y`
- Make installed: `sudo apt install make -y`
- Add your user to the docker group: `sudo usermod -aG docker $USER` then re-login

### Configuration files

**`srcs/.env`** — non-sensitive environment variables:
```
DOMAIN_NAME=masalvad.42.fr
MYSQL_DATABASE=inception
MYSQL_USER=masalvad
```

**`secrets/`** — sensitive credentials (never committed to Git):
```bash
mkdir secrets
echo "your_db_password"      > secrets/db_password.txt
echo "your_db_root_password" > secrets/db_root_password.txt
echo "your_wp_password"      > secrets/wp_password.txt
```

**`/etc/hosts`** — domain resolution:
```
127.0.1.1    masalvad.42.fr
```

## Building and launching with Makefile and Docker Compose

```bash
# Build all images and start containers in foreground
make

# Build and start in detached mode (background)
docker compose -f srcs/docker-compose.yml up -d

# Stop containers (preserves volumes and images)
make down

# Full clean: remove containers, images, and volumes
make clean

# Rebuild from scratch
make re
```

## Managing containers and volumes

**List running containers:**
```bash
sudo docker ps
```

**Enter a running container:**
```bash
sudo docker exec -it srcs-mariadb-1 bash
sudo docker exec -it srcs-wordpress-1 bash
sudo docker exec -it srcs-nginx-1 bash
```

**View logs:**
```bash
sudo docker logs srcs-mariadb-1
sudo docker logs -f srcs-wordpress-1   # follow live logs
```

**List volumes:**
```bash
sudo docker volume ls
```

**Inspect a volume:**
```bash
sudo docker volume inspect srcs_db_data
sudo docker volume inspect srcs_wp_volume
```

**Inspect the Docker network:**
```bash
sudo docker network inspect srcs_inception_network
```

## Data storage and persistence

| Volume | Mounted in | Contains |
|--------|------------|----------|
| `srcs_db_data` | `/var/lib/mysql` in `mariadb` | MariaDB database files |
| `srcs_wp_volume` | `/var/www/html` in `wordpress` and `nginx` | WordPress PHP files and uploads |

Data in these volumes persists across container restarts. It is only deleted when running `make clean` (which passes `-v` to `docker compose down`).

Volumes are stored on the host at:
```
/var/lib/docker/volumes/srcs_db_data/
/var/lib/docker/volumes/srcs_wp_volume/
```

## Project structure

```
.
├── Makefile
├── secrets/                  # Not committed to Git
│   ├── db_password.txt
│   ├── db_root_password.txt
│   └── wp_password.txt
└── srcs/
    ├── docker-compose.yml
    ├── .env                  # Not committed to Git
    └── requirements/
        ├── mariadb/
        │   ├── Dockerfile
        │   ├── conf/50-server.cnf
        │   └── tools/db.sh
        ├── wordpress/
        │   ├── Dockerfile
        │   ├── conf/www.conf
        │   └── tools/script.sh
        └── nginx/
            ├── Dockerfile
            └── conf/nginx.conf
```
