# Selfhosted

## Installation

### Create traefik network

```sh
docker network create --subnet=172.28.0.0/16 traefik
```
### Create/copy acme.json

```sh
touch traefik/acme.json
```

### Mount Dokumente

`sudo nano /etc/fstab`

```
//192.168.178.29/Dokumente /mnt/Dokumente      cifs    uid=1000,gid=1000,credentials=/root/.smblogin,rw,file_mode=0770,dir_mode=0770     0     0
```

```
# /root/.smblogin
username=<SMB_USER>
password=<SMB_PASS>
```

### Homeassistant Config anpassen

For Homeassistant to work, traefik has to be set as a trusted reverse proxy. Add the following to the `configuration.yaml` of Homeassistant:

```yaml
http:
  use_x_forwarded_for: true
  trusted_proxies:
    - 172.28.0.0/16
```

### Adguard

Configure the host to use local AdGuard instance

```sh
sudo nano /etc/dhcpcd.conf

# Add following line
static domain_name_servers=127.0.0.1

# Restart service
sudo service dhcpcd restart

# Test if it works
dig myservicer.mydomain.com
```

### Add Unifi DNS

Add rewrite in AdGuard: `unifi` => `${IP of Unifi Controller}`

### Start Tailscale

```sh
cd tailscale

docker-compose tailscale tailscale up
```

### Add Duplicacy filters

`.duplicacy/filters`

```
i:^\w+/$
i:^\w+/backup/
e:^\w+/$
e:.*
```

### Install SQLite

```
sudo apt-get install sqlite3
```
