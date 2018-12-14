#!/bin/bash
set -- `getopt a:b:c "$@"`


while [ -n "$1" ]
do
    case "$1" in 
     -a) echo "found option a and param = $2" 
         shift ;;
     -b) echo "found option b and param = $2"
         shift ;;
     -c) echo "found option c, no param." 
	shift ;;
    esac
    shift
done
