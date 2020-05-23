#!/bin/bash

## $1: search directory
## $2: grep options
## $3: search string

hdfs dfs -ls $1 | awk '{print $8}' | \
while read f; 
do 
    hdfs dfs -cat $f | grep $2 "$3" && echo $f; 
done