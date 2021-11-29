---
layout: post
title: Jekyll on haiku
---

gem install --user-install bundler jekyll
bundle config set --local path 'vendor/bundle'
bundle install

linux:
bundle exec /home/jonas/.gem/ruby/2.7.0/bin/jekyll.ruby2.7 serve

haiku maybe:
https://gist.github.com/sobstel/f6a490d854a2e5a214c3f2cd9c366032


/boot/system/develop/lib
/boot/system/develop/headers/libxml2/libxml

https://nokogiri.org/tutorials/installing_nokogiri.html#installing-using-standard-system-libraries

gem install --user-install nokogiri --platform=ruby -- --use-system-libraries \
                                                      --with-xml2-lib=/usr/local/lib \
                                                             --with-xml2-include=/usr/local/include/libxml2/libxml
                                                             gem install --user-install nokogiri --platform=ruby -- --use-system-libraries \
                                                                                                                   --with-xml2-lib=/boot/system/develop/lib \
                                                                                                                          --with-xml2-include=/boot/system/develop/headers/libxml2/libxml \
                                                                                                                                --with-xslt-lib= /boot/system/develop/lib \
                                                                                                                                      --with-xslt-include=/boot/system/develop/headers/libxslt

                                                                                                                                      pkgman install libxslt_devel

                                                                                                                                      bundle config build.nokogiri \
                                                                                                                                               --use-system-libraries \
                                                                                                                                                      --with-xml2-lib=/boot/system/develop/lib \
                                                                                                                                                             --with-xml2-include=/boot/system/develop/headers/libxml2/libxml \
                                                                                                                                                                   --with-xslt-lib= /boot/system/develop/lib \
                                                                                                                                                                         --with-xslt-include=/boot/system/develop/headers/libxslt


