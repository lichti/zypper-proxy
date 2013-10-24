#!/bin/bash

if [ "$1" = 'add' ]; then
	if [ -n "$2" ];then
		for FILE in /etc/zypp/repos.d/*
		do
			if [ $(grep proxy $FILE | wc -l) -eq 0 ];then
				echo "proxy=$$2" >> $FILE
			else
				sed -i s/proxy.*/proxy=$2/g $FILE
			fi
		done
	else
		echo "use: $0 add address:port"
	fi
elif [ "$1" = 'del' ]; then
	for FILE in /etc/zypp/repos.d/*
	do
		if [ $(grep proxy $FILE | wc -l) -gt 0 ];then
			sed -i s/proxy.*//g $FILE
		fi
	done
else
	echo "use: $0 add address:port"
	echo "use: $0 del"
fi
