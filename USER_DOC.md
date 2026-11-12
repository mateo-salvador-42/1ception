# USER_DOC — User Documentation

## What services does this stack provide?

The Inception stack runs three services:

- **NGINX** — the web server and sole entry point, accessible at `https://masalvad.42.fr` on port 443 (HTTPS only)
- **WordPress** — the website and its admin panel, powered by php-fpm
- **MariaDB** — the database storing all WordPress content

## Starting and stopping the stack

**Start:**
```bash
make
```

**Stop (keeps data):**
```bash
make down
```

**Full reset (deletes all data and images):**
```bash
make clean
make re
```

## Accessing the website

Open a browser and go to:
```
https://masalvad.42.fr
```

You may see a browser warning about the SSL certificate — this is expected since it is self-signed. Accept the exception to proceed.

## Accessing the WordPress admin panel

Go to:
```
https://masalvad.42.fr/wp-admin
```

Log in with the administrator credentials stored in `secrets/wp_password.txt`.

The admin username is `masalvad`.

## Locating and managing credentials

All sensitive credentials are stored in the `secrets/` directory at the root of the project (never committed to Git):

| File | Contents |
|------|----------|
| `secrets/db_password.txt` | MariaDB user password |
| `secrets/db_root_password.txt` | MariaDB root password |
| `secrets/wp_password.txt` | WordPress admin password |

Non-sensitive configuration is in `srcs/.env`:

| Variable | Description |
|----------|-------------|
| `DOMAIN_NAME` | The domain name of the site |
| `MYSQL_DATABASE` | The name of the WordPress database |
| `MYSQL_USER` | The MariaDB user for WordPress |

## Checking that services are running correctly

**Check container status:**
```bash
sudo docker ps
```

All three containers (`srcs-mariadb-1`, `srcs-wordpress-1`, `srcs-nginx-1`) should show status `Up`.

**Check logs for a specific service:**
```bash
sudo docker logs srcs-mariadb-1
sudo docker logs srcs-wordpress-1
sudo docker logs srcs-nginx-1
```

**Test the site with curl:**
```bash
curl -k https://masalvad.42.fr
```

A valid HTML response confirms the stack is working correctly.
