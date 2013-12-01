#!/bin/bash

title=""
creationDate=$(date --iso-8601)

if [[ $1 == "" ]]; then
	while [[ ${title} == "" ]]; do
		read -p "Title: " title 
	done
else
	title=$1
fi	

vim "${creationDate}-${title// /-}.markdown"
