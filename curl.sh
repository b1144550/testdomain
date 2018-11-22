#!/bin/bash


echo -e "check \033[30;48;5;82m http \033[0m :1"
echo -e "check \033[30;48;5;99m https \033[0m :2"
echo "custom :3"
read -p "(input 1 2 3):" method

function read_list(){
	file=list
	seq=1
	while read line
	do
		lines[$seq]=$line
		((seq++))
	done < $file

	for ((i=1;i<=${#lines[@]};i++))
	do
        httpcode=$(curl -sL $protocol://"${lines[$i]}" -o /dev/null -w "%{response_code}")        
        if  curl -sL http://"${lines[$i]}" | grep class > /dev/null  
        then
            echo -e "\033[30;48;5;82m ${lines[$i]} \033[0m" ,"$httpcode"
        else
            echo -e "\033[5m\033[30;48;5;196m ${lines[$i]} \033[0m " ,"$httpcode"
        fi
	done
}

case "$method" in
	1)
	protocol=http
	read_list
	;;
###################################2###################################################################

	2)
	protocol=https
	read_list
	;;
###############################################3#####################################################
    3)
	read -p "input domain: " domain
    httpcode=$(curl -sL "$domain" -o /dev/null -w "%{response_code}")
	if curl -Ls  "$domain" | grep class > /dev/null
        then
            echo -e "\033[30;48;5;82m $domain \033[0m", "$httpcode"
        else
            echo -e "\033[5m\033[30;48;5;196m $domain \033[0m", "$httpcode"
	fi
	;;

	*)
	exit 1
	;;
esac


