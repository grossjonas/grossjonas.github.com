---
layout: post
title: CHE and JHipster
---

[JHipster](https://jhipster.github.io/)

[Installation instructions from the site](https://jhipster.github.io/#quick)

```Assuming you have already installed Java, Git, Node.js, Bower, Yeoman and Gulp```

# How does this translate to installing

[JHipster in Docker Hub](https://hub.docker.com/r/jhipster/jhipster/)

``` bash
docker run -it \
  -p 8080:8080 \
  -p 3000:3000 \
  -p 3001:3001 \
  -v "$(pwd):/home/jhipster/app" \
  "jhipster/jhipster:latest" \
  bash
```

Workspaces -> Add Workspace

``` dockerfile
FROM ubuntu:xenial

RUN \
  # configure the "jhipster" user
  groupadd user && \
  useradd user -s /bin/bash -m -g user -G sudo && \
  echo 'user:user' |chpasswd && \

  # install open-jdk 8
  apt-get update && \
  apt-get install -y openjdk-8-jdk && \

  # install utilities
  apt-get install -y \
     wget \
     curl \
     vim \
     git \
     zip \
     bzip2 \
     fontconfig \
     python \
     g++ \
     gksu \
     openssh-server \
     build-essential && \

  # install node.js
  curl -sL https://deb.nodesource.com/setup_4.x | bash && \
  apt-get install -y nodejs && \

  # upgrade npm
  npm install -g npm && \

  # install yeoman bower gulp
  npm install -g \
    yo \
    bower \
    gulp-cli && \

  # cleanup
  apt-get clean && \
  rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*

RUN \
  # install jhipster
  npm install -g generator-jhipster

RUN mkdir /projects

RUN \
  # fix user permissions
  chown -R user:user \
    /projects \
    /home/user \
    /usr/lib/node_modules && \

  # cleanup
  rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*

RUN echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN \
mkdir -p /var/run/sshd/etc; \
cd /var/run/sshd/etc; \
ln -s /etc/localtime localtime

USER user

WORKDIR /projects

CMD sudo /usr/sbin/sshd -D && \
    tail -f /dev/null
```

Edit Commands -> Custom ->

    Name: run
    Command Line: cd ${current.project.path} && ./mvnw
    Preview URL: http://${server.port.8080}/

=> Preview URL is exactly ```http://${server.port.8080}/```, e.g. ```server.port.8080``` does not get resolved

Quick recap:
* ```sudo``` must be installed(Ubuntu package: gksu)
* privileged(aka sudoer) user called  ```user``` with ```${HOME}``` being ```/home/user``` and password ```user```, which is the "docker ```USER```"; so ```USER user``` is required
* directory ```/projects``` as ```WORKDIR```
* a functioning SSH-Server as ```CMD```, so last line must be ```CMD sudo /usr/sbin/sshd -D && tail -f /dev/null```

TODO:
* clean up dockerfile; maybe make it a gist; maybe base it on opensuse or alpine
* create CMD for ```yo jhipster```
* fix CMD for Maven wrapper ```./mvnw``` (or ```spring-boot:run``` + packaging aka ```mvn clean install```)
* maybe ```curl``` whole workspace (with commands)
