---
layout: post
title: CHE and JHipster
---

CHE is using Docker to privide defined environments for workspace.
You can provide your own Dockerfile by putting it's contents in

Workspaces -> Add Workspace -> Custom stack -> Write your own stack

[JHipster](https://jhipster.github.io/) provides a docker container. You can try it by running
``` bash
docker run -it \
  -p 8080:8080 \
  -p 3000:3000 \
  -p 3001:3001 \
  -v "$(pwd):/home/jhipster/app" \
  "jhipster/jhipster:latest" \
  bash
```

but this is not suitable for CHE because ```sudo``` is not installed.

So let's build an own Dockerfile.

You can't just add ```sudo``` to[JHipster's dockerfile](https://raw.githubusercontent.com/jhipster/generator-jhipster/master/Dockerfile) because it assumes you have the source in the current directory ... see this line
``` Dockerfile
COPY . /home/jhipster/generator-jhipster
```

So we start from scratch.

I choose OpenSUSE out of personal preference. Since it's an official image you only need

``` dockerfile
FROM opensuse:42.1
```

Now let's see [JHipster's installation instructions](https://jhipster.github.io/#quick)

```Assuming you have already installed Java, Git, Node.js, Bower, Yeoman and Gulp```

By ```Node.js``` they actually mean [npm - the node package manager](https://www.npmjs.com/).
[Bower](), [Yeoman]() and [Gulp]() are node packages. Just as JHipster itself.

OpenSUSE Leap 42.1's npm is a bit dated, which yield problems with the other packages. We can update it using ```npm``` itself.

So we'll add
``` dockerfile
RUN \
  zypper install --no-confirm \
    java-1_8_0-openjdk-devel \
    git \
    npm

RUN npm install --global npm
RUN npm install --global bower yo gulp-cli generator-jhipster
```

While trying dockerfile so far I get permission errors, because Yeoman expects to be [run as user](https://github.com/yeoman/yo/issues/101). So let's add a basic user and run the container as this user:

``` dockerfile
RUN \
  groupadd user && \
  useradd user -s /bin/bash -m -g user && \
  chown -R user:user /home/user

USER user

WORKDIR /home/user
```

Now I can run yeoman, but JHipster's Maven wrapper(```mvnw```) fails because of missing ```${JAVA_HOME}```.

Let's fix this:
``` dockerfile
RUN \
  echo "" >> /home/user/.bashrc ; \
  echo "export JAVA_HOME=/etc/alternatives/java_sdk" >> /home/user/.bashrc ;  
```

So now we have a working dockerfile for JHipster that looks like this:
``` dockerfile
FROM opensuse:42.1

RUN zypper install --no-confirm \
  java-1_8_0-openjdk-devel \
  git \
  npm

RUN npm install --global npm
RUN npm install --global bower yo gulp-cli generator-jhipster

RUN \
  groupadd user && \
  useradd user -s /bin/bash -m -g user && \
  chown -R user:user /home/user

Run \
  echo "" >> /home/user/.bashrc ; \
  echo "export JAVA_HOME=/etc/alternatives/java_sdk" >> /home/user/.bashrc ;

USER user

WORKDIR /home/user
```

#Halftime

In CHE dockerfiles are called stacks. You can provide your own dockerfile/stack under

Workspaces -> Add Workspace -> Custom Stack -> Write your own stack

Copy and pasting the dockerfile above I get:
```<blabla> No command specified```

By looking at the [provided dockerfiles](https://github.com/codenvy/dockerfiles/) you can see that all of them end with
``` dockerfile
CMD tail -f /dev/null
```
and specify
``` dockerfile
WORKDIR /projects
```

Okay let's adapt.
``` dockerfile
RUN \
  mkdir /projects && \
  chown user:user /projects

USER user

WORKDIR /projects

CMD tail -f /dev/null
```

and another error:
```
/bin/bash: unzip: command not found
```
so
``` dockerfile
RUN \
  zypper install --no-confirm unzip
```

and another one:
```
/bin/bash: sudo: command not found
```

so add it and (taking the short route) allow ```user``` to use it
``` dockerfile
RUN \
  zypper install --no-confirm \
    unzip \
    sudo

RUN echo "%user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers    
```

So now we got a first running version. Compiled together it's:

``` dockerfile
FROM opensuse:42.1

RUN zypper install --no-confirm \
  java-1_8_0-openjdk-devel \
  git \
  npm

RUN npm install --global npm
RUN npm install --global bower yo gulp-cli generator-jhipster

RUN \
  groupadd user && \
  useradd user -s /bin/bash -m -g user && \
  chown -R user:user /home/user

RUN \
  echo "" >> /home/user/.bashrc && \
  echo "export JAVA_HOME=/etc/alternatives/java_sdk" >> /home/user/.bashrc

RUN \
  mkdir /projects && \
  chown user:user /projects

RUN \
  zypper install --no-confirm \
    unzip \
    sudo

RUN \
  echo "%user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
  echo "Defaults        lecture = never" >> /etc/sudoers.d/privacy

USER user

WORKDIR /projects

CMD tail -f /dev/null
```

<hr />

``` dockerfile
RUN echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN   echo 'user:user' |chpasswd

RUN zypper in openssh

RUN \
  # fix user permissions
  chown -R user:user \
    /projects \

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

* also install Maven for ```mvn spring-boot:run```


Additional notes:
* [JHipster in Docker Hub](https://hub.docker.com/r/jhipster/jhipster/)

```
yo jhipster && gulp install
``` 
