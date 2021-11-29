---
layout: post
title: Jekyll on haiku
---

``` bash
gem install --user-install bundler
bundle config set --local path 'vendor/bundle'
bundle install

# https://nokogiri.org/tutorials/installing_nokogiri.html#installing-using-standard-system-libraries

pkgman install libxslt
pkgman install libxslt_devel
pkgman install libxml2
pkgman install libxml2_devel

gem install --user-install nokogiri --platform=ruby -- --use-system-libraries \
    --with-xml2-lib=/boot/system/develop/lib \
    --with-xml2-include=/boot/system/develop/headers/libxml2/libxml \
    --with-xslt-lib= /boot/system/develop/lib \
    --with-xslt-include=/boot/system/develop/headers/libxslt

bundle config build.nokogiri \
    --use-system-libraries \
    --with-xml2-lib=/boot/system/develop/lib \
    --with-xml2-include=/boot/system/develop/headers/libxml2/libxml \
    --with-xslt-lib= /boot/system/develop/lib \
    --with-xslt-include=/boot/system/develop/headers/libxslt

gem install --user-install jekyll

~> tail config/settings/profile
export PATH="/boot/home/.gem/ruby/2.7.0/bin:${PATH}"
```

Bonus

``` bash
bundle exec jekyll serve --drafts --future
```
