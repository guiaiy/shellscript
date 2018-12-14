#!/bin/bash
while :
do
y=0
h=0
p1=$[RANDOM%6+1]
p2=$[RANDOM%6+1]
p3=$[RANDOM%6+1]
p4=$[RANDOM%6+1]
p5=$[RANDOM%6+1]
j1=$[RANDOM%6+1]
j2=$[RANDOM%6+1]
j3=$[RANDOM%6+1]
j4=$[RANDOM%6+1]
j5=$[RANDOM%6+1]
echo '你的色子是'
echo "$p1,$p2,$p3,$p4,$p5"
echo
p=0
while [ $y -eq 0 ]
do
a1=0
a2=0
a3=0
a4=0
a5=0
a6=0
read -p  '请输入数量:  ' n 
read -p  '请输入点数:  ' d
echo "你说，$n 个 $d"
echo
if [ $d -eq 1 ];then
	h=1
	case $j1 in
	1) let a1++;;
	esac
	case $j2 in
	1) let a1++;;
	esac
	case $j3 in
	1) let a1++;;
	esac
	case $j4 in
	1) let a1++;;
	esac
	case $j5 in
	1) let a1++;;
	esac
	if [ $n -le 4 ];then
	p=$[a1+n-1]
	else
	p=$[a1+4]
	fi
		if [ $n -ge $p ];then
		echo '电脑说：开'
		echo
		y=1
		else
		m=$[RANDOM%6+1]
		u=$[p-1]
		l=$[RANDOM%6+1]
		case $l in
		1)
			while :
			do
			if [ $m -gt 1 ] && [ $u -lt $n ];then
			let u++
			elif [ $u -le $n ];then
			let u++
			else
			break
			fi
			done
			echo "电脑说：$u 个 $m"
			read -p "你开吗？y:  " i
			echo
			if [ "$i" == "y" ];then
			y=2
			break
			fi;;
		*)
			m=0
			case $j1 in
			2) let a2++;;
			esac
			case $j2 in
			2) let a2++;;
			esac
			case $j3 in
			2) let a2++;;
			esac
			case $j4 in
			2) let a2++;;
			esac
			case $j5 in
			2) let a2++;;
			esac
			case $j1 in
			3) let a3++;;
			esac
			case $j2 in
			3) let a3++;;
			esac
			case $j3 in
			3) let a3++;;
			esac
			case $j4 in
			3) let a3++;;
			esac
			case $j5 in
			3) let a3++;;
			esac
			case $j1 in
			4) let a4++;;
			esac
			case $j2 in
			4) let a4++;;
			esac
			case $j3 in
			4) let a4++;;
			esac
			case $j4 in
			4) let a4++;;
			esac
			case $j5 in
			4) let a4++;;
			esac
			case $j1 in
			5) let a5++;;
			esac
			case $j2 in
			5) let a5++;;
			esac
			case $j3 in
			5) let a5++;;
			esac
			case $j4 in
			5) let a5++;;
			esac
			case $j5 in
			5) let a5++;;
			esac
			case $j1 in
			6) let a6++;;
			esac
			case $j2 in
			6) let a6++;;
			esac
			case $j3 in
			6) let a6++;;
			esac
			case $j4 in
			6) let a6++;;
			esac
			case $j5 in
			6) let a6++;;
			esac
			if [ $a1 -gt $a2 ];then
			num=$a1
			a1=$a2
			a2=$num
			fi
			if [ $a2 -gt $a3 ];then
			num=$a2
			a2=$a3
			a3=$num
			fi
			if [ $a3 -gt $a4 ];then
			num=$a3
			a3=$a4
			a4=$num
			fi
			if [ $a4 -gt $a5 ];then
			num=$a4
			a4=$a5
			a5=$num
			fi
			if [ $a5 -gt $a6 ];then
			num=$a5
			a5=$a6
			a6=$num
			fi
			while :
			do
			if [ $a6 -gt $d ] && [ $u -lt $n ];then
			let u++
			elif [ $u -le $n ];then
			let u++
			else
			break
			fi
			done
			echo "电脑说：$u 个 $a6"
			read -p "你开吗？y:  " i
			echo
			if [ "$i" == "y" ];then
			y=2
			break
			fi;;
		esac
		fi
else
	if [ $h -eq 1 ];then
	case $j1 in
	$d) let a1++;;
	esac
	case $j2 in
	$d) let a1++;;
	esac
	case $j3 in
	$d) let a1++;;
	esac
	case $j4 in
	$d) let a1++;;
	esac
	case $j5 in
	$d) let a1++;;
	esac
		if [ $n -le 4 ];then
		p=$[a1+n-2]
		else
		p=$[a1+3]
		fi
		if [ $n -gt $p ];then
		echo '电脑说：开'
		echo
		y=1
		else
		m=$[RANDOM%6+1]
		u=$[p-1]
		l=$[RANDOM%6+1]
		case $l in
		1)
			while :
			do
			if [ $m -gt $d ] && [ $u -lt $n ];then
			let u++
			elif [ $u -le $n ];then
			let u++
			else
			break
			fi
			done
			echo "电脑说：$u 个 $m"
			read -p "你开吗？y:  " i
			echo
			if [ "$i" == "y" ];then
			y=2
			break
			fi;;
		*)
			m=0
			case $j1 in
			2) let a2++;;
			esac
			case $j2 in
			2) let a2++;;
			esac
			case $j3 in
			2) let a2++;;
			esac
			case $j4 in
			2) let a2++;;
			esac
			case $j5 in
			2) let a2++;;
			esac
			case $j1 in
			3) let a3++;;
			esac
			case $j2 in
			3) let a3++;;
			esac
			case $j3 in
			3) let a3++;;
			esac
			case $j4 in
			3) let a3++;;
			esac
			case $j5 in
			3) let a3++;;
			esac
			case $j1 in
			4) let a4++;;
			esac
			case $j2 in
			4) let a4++;;
			esac
			case $j3 in
			4) let a4++;;
			esac
			case $j4 in
			4) let a4++;;
			esac
			case $j5 in
			4) let a4++;;
			esac
			case $j1 in
			5) let a5++;;
			esac
			case $j2 in
			5) let a5++;;
			esac
			case $j3 in
			5) let a5++;;
			esac
			case $j4 in
			5) let a5++;;
			esac
			case $j5 in
			5) let a5++;;
			esac
			case $j1 in
			6) let a6++;;
			esac
			case $j2 in
			6) let a6++;;
			esac
			case $j3 in
			6) let a6++;;
			esac
			case $j4 in
			6) let a6++;;
			esac
			case $j5 in
			6) let a6++;;
			esac
			if [ $a1 -gt $a2 ];then
			num=$a1
			a1=$a2
			a2=$num
			fi
			if [ $a2 -gt $a3 ];then
			num=$a2
			a2=$a3
			a3=$num
			fi
			if [ $a3 -gt $a4 ];then
			num=$a3
			a3=$a4
			a4=$num
			fi
			if [ $a4 -gt $a5 ];then
			num=$a4
			a4=$a5
			a5=$num
			fi
			if [ $a5 -gt $a6 ];then
			num=$a5
			a5=$a6
			a6=$num
			fi
			while :
			do
			if [ $a6 -gt $d ] && [ $u -lt $n ];then
			let u++
			elif [ $u -le $n ];then
			let u++
			else
			break
			fi
			done
			echo "电脑说：$u 个 $a6"
			read -p "你开吗？y:  " i
			echo
			if [ "$i" == "y" ];then
			y=2
			break
			fi;;
		esac
		fi
	else
	case $j1 in
	$d|1) let a1++;;
	esac
	case $j2 in
	$d|1) let a1++;;
	esac
	case $j3 in
	$d|1) let a1++;;
	esac
	case $j4 in
	$d|1) let a1++;;
	esac
	case $j5 in
	$d|1) let a1++;;
	esac
		if [ $n -le 3 ];then
		p=$[a1+n]
		else
		p=$[a1+4]
		fi
		if [ $n -gt $p ];then
		echo '电脑说：开'
		echo
		y=1
		else
		m=$[RANDOM%5+2]
		u=$[p-1]
		l=$[RANDOM%6+1]
		case $l in
		1)
			while :
			do
			if [ $m -gt $d ] && [ $u -lt $n ];then
			let u++
			elif [ $u -le $n ];then
			let u++
			else
			break
			fi
			done
			echo "电脑说：$u 个 $m"
			read -p "你开吗？y:  " i
			echo
			if [ "$i" == "y" ];then
			y=2
			break
			fi;;
		*)
			m=0
			case $j1 in
			2|1) let a2++;;
			esac
			case $j2 in
			2|1) let a2++;;
			esac
			case $j3 in
			2|1) let a2++;;
			esac
			case $j4 in
			2|1) let a2++;;
			esac
			case $j5 in
			2|1) let a2++;;
			esac
			case $j1 in
			3|1) let a3++;;
			esac
			case $j2 in
			3|1) let a3++;;
			esac
			case $j3 in
			3|1) let a3++;;
			esac
			case $j4 in
			3|1) let a3++;;
			esac
			case $j5 in
			3|1) let a3++;;
			esac
			case $j1 in
			4|1) let a4++;;
			esac
			case $j2 in
			4|1) let a4++;;
			esac
			case $j3 in
			4|1) let a4++;;
			esac
			case $j4 in
			4|1) let a4++;;
			esac
			case $j5 in
			4|1) let a4++;;
			esac
			case $j1 in
			5|1) let a5++;;
			esac
			case $j2 in
			5|1) let a5++;;
			esac
			case $j3 in
			5|1) let a5++;;
			esac
			case $j4 in
			5|1) let a5++;;
			esac
			case $j5 in
			5|1) let a5++;;
			esac
			case $j1 in
			6|1) let a6++;;
			esac
			case $j2 in
			6|1) let a6++;;
			esac
			case $j3 in
			6|1) let a6++;;
			esac
			case $j4 in
			6|1) let a6++;;
			esac
			case $j5 in
			6|1) let a6++;;
			esac
			if [ $a1 -gt $a2 ];then
			num=$a1
			a1=$a2
			a2=$num
			fi
			if [ $a2 -gt $a3 ];then
			num=$a2
			a2=$a3
			a3=$num
			fi
			if [ $a3 -gt $a4 ];then
			num=$a3
			a3=$a4
			a4=$num
			fi
			if [ $a4 -gt $a5 ];then
			num=$a4
			a4=$a5
			a5=$num
			fi
			if [ $a5 -gt $a6 ];then
			num=$a5
			a5=$a6
			a6=$num
			fi
			while :
			do
			if [ $a6 -gt $d ] && [ $u -lt $n ];then
			let u++
			elif [ $u -le $n ];then
			let u++
			else
			break
			fi
			done
			echo "电脑说：$u 个 $a6"
			read -p "你开吗？y:  " i
			echo
			if [ "$i" == "y" ];then
			y=2
			break
			fi;;
		esac
		fi
	fi
fi
done
echo "电脑： $j1,$j2,$j3,$j4,$j5"
echo "你  ： $p1,$p2,$p3,$p4,$p5"
if [ $y -eq 1 ] && [ $h -eq 1 ];then
c=0
case $j1 in
$d) let c++
esac
case $j2 in
$d) let c++
esac
case $j3 in
$d) let c++
esac
case $j4 in
$d) let c++
esac
case $j5 in
$d) let c++
esac
case $p1 in
$d) let c++
esac
case $p2 in
$d) let c++
esac
case $p3 in
$d) let c++
esac
case $p4 in
$d) let c++
esac
case $p5 in
$d) let c++
esac
	if [ $c -ge $n ];then
	echo '你赢了'
	else
	echo '你输了'
	fi
elif [ $y -eq 1 ] && [ $h -eq 0 ];then
c=0
case $j1 in
$d|1) let c++
esac
case $j2 in
$d|1) let c++
esac
case $j3 in
$d|1) let c++
esac
case $j4 in
$d|1) let c++
esac
case $j5 in
$d|1) let c++
esac
case $p1 in
$d|1) let c++
esac
case $p2 in
$d|1) let c++
esac
case $p3 in
$d|1) let c++
esac
case $p4 in
$d|1) let c++
esac
case $p5 in
$d|1) let c++
esac
	if [ $c -ge $n ];then
	echo '你赢了'
	else
	echo '你输了'
	fi
fi
if [ $y -eq 2 ] && [ $h -eq 1 ];then
c=0
case $j1 in
$m|$a6) let c++
esac
case $j2 in
$m|$a6) let c++
esac
case $j3 in
$m|$a6) let c++
esac
case $j4 in
$m|$a6) let c++
esac
case $j5 in
$m|$a6) let c++
esac
case $p1 in
$m|$a6) let c++
esac
case $p2 in
$m|$a6) let c++
esac
case $p3 in
$m|$a6) let c++
esac
case $p4 in
$m|$a6) let c++
esac
case $p5 in
$m|$a6) let c++
esac
	if [ $c -lt $p ];then
	echo '你赢了'
	else
	echo '你输了'
	fi
elif [ $y -eq 2 ] && [ $h -eq 0 ];then
c=0
case $j1 in
$m|1|$a6) let c++
esac
case $j2 in
$m|1|$a6) let c++
esac
case $j3 in
$m|1|$a6) let c++
esac
case $j4 in
$m|1|$a6) let c++
esac
case $j5 in
$m|1|$a6) let c++
esac
case $p1 in
$m|1|$a6) let c++
esac
case $p2 in
$m|1|$a6) let c++
esac
case $p3 in
$m|1|$a6) let c++
esac
case $p4 in
$m|1|$a6) let c++
esac
case $p5 in
$m|1|$a6) let c++
esac
	if [ $c -lt $p ];then
	echo '你赢了'
	else
	echo '你输了'
	fi
fi
read -p '你继续吗？n:  ' v
echo
if [ "$v" == "n" ];then
exit
fi
done
