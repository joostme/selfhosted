# Selfhosted

## Installation

### Create traefik network

```sh
docker network create traefik
```

### Mount Dokumente

`sudo nano /etc/fstab`

```
//192.168.178.29/Dokumente /mnt/Dokumente      cifs    uid=1000,gid=1000,guest,rw,file_mode=0770,dir_mode=0770     0     0
```