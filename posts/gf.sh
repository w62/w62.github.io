#!/bin/bash

gen_file_header () {
	echo "---  " >> $1
	echo "layout: post  " >> $1
	echo "title: $2  " >> $1
	echo "date: $(date '+%Y-%m-%d %H:%M:%S %z')  " >> $1
	echo "categories: post  " >> $1
	echo >> $1
	echo "---  " >> $1
}

FILENAME=$(date '+%Y-%m-%d-%H-%M-%S').md

echo $FILENAME

if [ "$#" -ne 1 ]
then
	echo "Usage: $0 <Title of post>"
else
	echo "Title of post is: $1"
	gen_file_header "$FILENAME" "$1"
	echo "$FILENAME generated"
fi


