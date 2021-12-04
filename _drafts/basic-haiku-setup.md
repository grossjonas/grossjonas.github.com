---
layout: post
title: Basic haiku setup
---

Recently I had a lot of fun exploring [haiku os|https://www.haiku-os.org/].
In fact so much fun that I wanted to write about it ... even that long of a pause.

# basics

ToDo: text here!
C & Posix 
https://www.haiku-os.org/docs/api/libroot.html

``` bash
pkgman update
shutdown -r
pkgman install -y git vim
pkgman install falkon
```

## spacevim

ToDo: text here!

``` bash
cd $HOME
curl -sLf https://spacevim.org/install.sh | bash -s -- --checkRequirements
curl -sLf https://spacevim.org/install.sh | bash -s -- --install vim
mv .vim config/setting/vim
vim 
# select prefered mode and :q
vim
# to install plugins
#mkdir /system/non-packaged/data/fonts/ttfonts
#mv .local/share/fonts/* /system/non-packaged/data/fonts/ttfonts/
```

## ssh & git

ToDo: text here!

``` bash
mkdir /boot/home/config/settings/ssh
cd /boot/home/config/settings/ssh
ssh-keygen -o -a 100 -t ed25519 -f github
cat github.pub
# ssh-ed25519 ABC<not some many letters>abc user@shredder
tail config
# Host github.com
#    IdentityFile ~/config/settings/ssh/github
```

