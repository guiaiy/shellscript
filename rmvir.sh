#!/bin/bash
set -- `getopt b: "$@"`
	case $1 in
	-b)	if [ $# -eq 5 ];then
			for i in `seq $4  $5`
			do
				virsh destroy $2$i &> /dev/null
				virsh undefine $2$i
				rm -rf /var/lib/libvirt/images/$2$i.*
				rm -rf /var/lib/libvirt/images/.$2${i}bak.*
				virsh destroy $2$i &> /dev/null
			done
		elif [ $# -lt  5 ];then
			virsh destroy $2$4 &> /dev/null
			virsh undefine $2$4
			rm -rf /var/lib/libvirt/images/$2$4.*
			rm -rf /var/lib/libvirt/images/.$2$4\\bak.*
			virsh destroy $2$4 &> /dev/null
		fi;;
	*)	for i in $@
 		do	 
			[ $i == "--" ] && continue 
			virsh destroy $i &> /dev/null
			virsh undefine $i
			rm -rf /var/lib/libvirt/images/$i.*
			rm -rf /var/lib/libvirt/images/.${i}bak.*
			virsh destroy $i &> /dev/null
		done ;;
	esac

