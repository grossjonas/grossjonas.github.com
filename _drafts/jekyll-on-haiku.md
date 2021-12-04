---
layout: post
title: Jekyll on haiku
---

``` bash
pkgman install ruby_devel -y
gem install --user-install bundler
bundle config set --local path 'vendor/bundle'

pkgman install libxslt libxslt_devel libxml2 libxml2_devel -y

# this should set these values globally (unless you are in ruby project directory)

bundle config build.nokogiri \
    --use-system-libraries \
    --with-xml2-lib=/boot/system/develop/lib \
    --with-xml2-include=/boot/system/develop/headers/libxml2/libxml \
    --with-xslt-lib= /boot/system/develop/lib \
    --with-xslt-include=/boot/system/develop/headers/libxslt

gem install --user-install jekyll

echo 'export PATH="/boot/home/.gem/ruby/2.7.0/bin:${PATH}"' >> /boot/home/config/settings/profile
# source or restart your shell

# cd to your jekyll directory
bundle install

# https://nokogiri.org/tutorials/installing_nokogiri.html#installing-using-standard-system-libraries

#gem install --user-install nokogiri --platform=ruby -- --use-system-libraries \
#    --with-xml2-lib=/boot/system/develop/lib \
#    --with-xml2-include=/boot/system/develop/headers/libxml2/libxml \
#    --with-xslt-lib= /boot/system/develop/lib \
#    --with-xslt-include=/boot/system/develop/headers/libxslt

```

Bonus

``` bash
bundle exec jekyll serve --drafts --future
```
