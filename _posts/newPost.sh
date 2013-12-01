#!/bin/bash

creationDate=$(date --iso-8601)
title=$1

vim "${creationDate}-${title// /-}.markdown"
