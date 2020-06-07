---
layout: post
title: SSH config and Github
---

If you are using github you are probably using ssh keys for convience.
These are great - not only for convience but more so for security.

I myself like giving my keys clear names and adding them to a [SSH config file](http://nerderati.com/2011/03/17/simplify-your-life-with-an-ssh-config-file/).
So [Github's execellent tutorials](https://help.github.com/articles/generating-an-ssh-key/) are not taking me the whole way ... reason enough to write it all together here and now.

So let's play this through with github as example.

It is about time to move to elliptic curves. A great write up about it is [here](https://blog.g3rt.nl/upgrade-your-ssh-keys.html). That's where I got the ```ssh-keygen``` parameters from.

With all that in mind I start with a terminal on local machine:

``` bash
KEY_FILE="${HOME}/.ssh/github"
ssh-keygen -o -a 100 -t ed25519 -f "${KEY_FILE}"
# On "Enter passphrase (empty for no passphrase): " type a good (== long) passphrase
ssh-add ${KEY_FILE}
# Now you enter your passphrase again for convient storage in ssh-agent
```

The next step is adding your key to github. Github has a nice tutorial using ```xclip``` [here](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/). It boils down to

``` bash
xclip -sel clip < "${KEY_FILE}.pub"
```
and pasting it in the right place on their website.

For some remote machine this might invoke using ```ssh-copy-id``` or adding your key manually to some ```~/.ssh/authorized_keys``` file (like the barbarian I was 10 years ago).


My last step is adding the key to ```~/.ssh/config```, like this:

```
Host github.com
  IdentityFile ~/.ssh/github
```

There are many other parameters. Just look at

```
man ssh_config
```
and tweak according to your needs.

So now let's commit & push something ;)
