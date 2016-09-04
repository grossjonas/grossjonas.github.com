---
layout: post
title: Building an authorization workflow with spring boot and spring security
---

User Stories:
"As someone who is no user yet, I want to register by e-mail so that I can be sure everyone's e-mail is valid."
"As someone who is no user yet, I want to provide my password upon registration so no one can grap my verification page and set it there"
"As a registered user, I want to verify and actually create my full user acount by visiting a special website"
"As a full user, I want to login by providing e-mail and password so that I can login everywhere just by knowing e-mail and password"
"As a full user, I want the option to remember my login per browser so that I do not need to enter it all the time"

Testing:
https://spring.io/guides/gs/testing-web/
-> junit, mockito, assertJ

==> Cucumber?

Password encryption:
(Good guide for Java - a little dated)[http://jasypt.org/howtoencryptuserpasswords.html]
(Another guide - not specific to Java, 2016)[https://crackstation.net/hashing-security.htm]
(stackexchange question)[http://security.stackexchange.com/questions/131487/list-of-vulnerable-and-usable-hash-functions]
==> BCrypt, SCrypt, PBKDF2(NIST Standard)

(Password Hashing Competition - 2015)[https://de.wikipedia.org/wiki/Password_Hashing_Competition]
=> Argon2

(Best Blog Post yet)[https://paragonie.com/blog/2016/02/how-safely-store-password-in-2016]
