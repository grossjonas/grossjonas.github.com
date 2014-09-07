---
layout: post
title:  "libevhtp and ubuntu 14.04"
categories: c_programming libs gcc
---

    sudo apt-get install cmake libevent-dev libssl-dev build-essential

    gcc -o a.out test.c -levhtp -lpthread -levent -levent_openssl -lssl -lcrypto
