# Selfhosted

## Rootless Setup

Mostly follow the [official guide](https://docs.docker.com/engine/security/rootless/).

### Allow < 1024 ports
```sh
sudo setcap cap_net_bind_service=ep $(which rootlesskit)
sudo echo "net.ipv4.ip_unprivileged_port_start=80" > /etc/sysctl.d/100-rootless-docker.conf
sudo sysctl --system
systemctl --user restart docker
```

### Forward Client IP
Run this as the rootless user running the docker containers.

```sh 
cat << EOF > ~/.config/systemd/user/docker.service.d/override.conf
[Service]
Environment="DOCKERD_ROOTLESS_ROOTLESSKIT_PORT_DRIVER=slirp4netns"
EOF 
```

## Fail2ban
Copy the files from `fail2ban` into the corresponding folders in `/etc/fail2ban`.

You can test if a filter correctly works by running

```sh
fail2ban-regex -m CONTAINER_TAG=<MY_CONTAINER> systemd-journal[journalflags=1] '<MY_REGEX>'
```

## Installation

### Create NGINX Proxy Manager network

```sh
docker network create npm
```
### Install SQLite

```
sudo apt-get install sqlite3
```
