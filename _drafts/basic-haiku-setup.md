---
layout: post
title: Basic haiku setup
---


spacevim

cd $HOME
curl -sLf https://spacevim.org/install.sh | bash
mv .vim config/setting/vim 
mkdir /system/non-packaged/data/fonts/ttfonts
mv .local/share/fonts/* /system/non-packaged/data/fonts/ttfonts/


git

¨/config/settings/ssh

¨/config/settings/ssh> cat github.pub 
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGP+K8/NX3zxHK+UGwR82AB5cZ1tojIVHFLJPusZ2Ooj user@shredder


~/git/grossjonas.github.com> cd
~> tail config/settings/ssh/config 
Host github.com
    IdentityFile ~/config/settings/ssh/github

    
