---
layout: post
title: Building an authorization workflow with spring boot and spring security
---

User Stories:


Password encryption:
(Good guide for Java - a little dated)[http://jasypt.org/howtoencryptuserpasswords.html]
(Another guide - not specific to Java, 2016)[https://crackstation.net/hashing-security.htm]
(stackexchange question)[http://security.stackexchange.com/questions/131487/list-of-vulnerable-and-usable-hash-functions]
==> BCrypt, SCrypt, PBKDF2(NIST Standard)

(Password Hashing Competition - 2015)[https://de.wikipedia.org/wiki/Password_Hashing_Competition]
=> Argon2

(Best Blog Post yet)[https://paragonie.com/blog/2016/02/how-safely-store-password-in-2016]
