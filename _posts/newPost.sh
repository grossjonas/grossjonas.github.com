#!/bin/bash

title=""
creationDate=$(date --iso-8601)

if [[ $1 == "" ]]; then
	echo "no arg"
else
	title=$1
	vim "${creationDate}-${title// /-}.markdown"
fi	

