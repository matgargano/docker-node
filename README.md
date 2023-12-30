- spin up new box (ubuntu, etc)
  - apt upgrade
  - apt update
- point domain to IP of box (e.g. `domain.tld`)
- create new user, e.g.,
  ```
  adduser gensite
  usermod -aG sudo gensite
  ```
- switch to user (e.g., `su gensite`)
- install docker and docker-compose `sudo apt install docker.io docker-compose`
- clone this repo and `cd` into the repo
- add .env file:
  ```
  DOMAIN_NAME=domain.tld
  EMAIL=foo@bar.com
  PORT=3000
  ```
-
- add user to docker group e.g.
  ```
  sudo usermod -aG docker gensite
  ```
- log out and log back in (e.g., `exit` then `su gensite`)
- create group `newgrp docker`
- you can check now permissions running `docker run hello-world` should not return permission errors, if so then you're good
- run `docker-compose up --build -d`
