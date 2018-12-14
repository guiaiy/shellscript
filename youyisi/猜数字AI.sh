#!/bin/bash
a1=0
b1=1
c1=2
d1=3
echo "电脑猜的是 0 1 2 3"
while :
do
echo "请输入电脑的匹配值"
read -p "A: " aaa
read -p "B: " bbb
aa=${aaa:-0}
bb=${bbb:-0}
read -p "确认Y(大写)： " yy
if [ "$yy" == "Y" ];then
break
fi
done
index=0
for i in {0..9}
do
a=$i
	for j in {0..9}
	do
	b=$j
		for k in {0..9}
		do
		c=$k 
			for m in {0..9}
			do
			d=$m
			if [ $a -ne $b ] && [ $a -ne $c ] && [ $a -ne $d ] && [ $b -ne $c ] && [ $b -ne $d ] && [ $c -ne $d ];then
                A=0
                B=0
                case $a1 in
                $a) let A++;;
                $b|$c|$d) let B++;;
                esac
                case $b1 in
                $b) let A++;;
                $a|$c|$d) let B++;;
                esac
                case $c1 in
                $c) let A++;;
                $b|$a|$d) let B++;;
                esac
                case $d1 in
                $d) let A++;;
                $b|$c|$a) let B++;;
                esac
if [ $A -eq $aa ] && [ $B -eq $bb ];then
			p="$a$b$c$d"
			shuzu[$index]=$p
			let index++
fi
			fi
			done
		done
	done
done
echo
u=0
while :
do
let u++
n=${#shuzu[@]}
p=$[RANDOM%n]
a1=${shuzu[$p]:0:1}
b1=${shuzu[$p]:1:1}
c1=${shuzu[$p]:2:1}
d1=${shuzu[$p]:3:1}
echo "电脑猜的是 $a1 $b1 $c1 $d1"
while :
do
echo "请输入电脑的匹配值"
read -p "A: " aaa
read -p "B: " bbb
aa=${aaa:-0}
bb=${bbb:-0}
read -p "确认Y(大写)： " yy
if [ "$yy" == "Y" ];then
break
fi
done
echo
##while :
##do
##read -p "A: " aa
##read -p "B: " bb
##read -p "确认Y(大写)： " yy
##if [ "$yy" == "Y" ];then
##break
##fi
##done
	if [ $aa -eq 4 ];then
	echo '电脑猜对了'
	cishu=$[u+1]
	echo "电脑猜了$cishu 次"
	break
	else
		index=0
		for ii in `seq $n`
		do
		i=$[ii-1]
		a=${shuzu[$i]:0:1}
		b=${shuzu[$i]:1:1}
		c=${shuzu[$i]:2:1}
		d=${shuzu[$i]:3:1}
		A=0
		B=0
		case $a1 in
		$a) let A++;;
		$b|$c|$d) let B++;;
		esac
		case $b1 in
		$b) let A++;;
		$a|$c|$d) let B++;;
		esac
		case $c1 in
		$c) let A++;;
		$b|$a|$d) let B++;;
		esac
		case $d1 in
		$d) let A++;;
		$b|$c|$a) let B++;;
		esac
			if [ $A -eq $aa ] && [ $B -eq $bb ];then
			str="$a$b$c$d"
			shuzub[$index]=$str
			let index++
			x=`echo "scale=2;$i/$n" | bc`
			x2=`echo "$x*100/1" | bc`
			echo -ne "计算机计算中$x2% \r"
			fi
		done
		shuzu=("${shuzub[@]}")
		unset shuzub
	fi
done
