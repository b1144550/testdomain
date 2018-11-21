#!/bin/bash


echo -e "check \e[30;48;5;82m http \e[0m :1"
echo -e "check \e[30;48;5;99m https \e[0m :2"
echo "custom :3"
read -p "(input 1 2 3):" method

case "$method" in
	1)
	file=list
	seq=1
	while read line
	do
		lines[$seq]=$line
		((seq++))
	done < $file


	
	for ((i=1;i<=${#lines[@]};i++))
	do
        #httpscode=$(curl -sL https://"${lines[$i]}" -o /dev/null -w "https response code: %{response_code}")
        httpcode=$(curl -sL http://"${lines[$i]}" -o /dev/null -w "code: %{response_code}")
        #http=$(curl -sL http://"${lines[$i]}" | grep title > /dev/null )
       # https=$(curl -sL https://"${lines[$i]}" | grep title > /dev/null )
        
        #if [  "$http" != null ]
        if  curl -sL http://"${lines[$i]}" | grep class > /dev/null  
        then
            echo -e "\e[30;48;5;82m ${lines[$i]} \e[0m" ,"$httpcode"

        else
            echo -e "\e[5m\e[30;48;5;196m ${lines[$i]} \e[0m " ,"$httpcode"
        fi
        

	done
    
	;;

###################################2################################################

	2)
	file=list
	seq=1
	while read line
	do
		lines[$seq]=$line
		((seq++))
	done < $file


	
	for ((i=1;i<=${#lines[@]};i++))
	do
        httpscode=$(curl -sL https://"${lines[$i]}" -o /dev/null -w "code: %{response_code}")
#        https=$(curl -sL https://"${lines[$i]}" | grep title > /dev/null )
        
        if curl -sL https://"${lines[$i]}" | grep class > /dev/null 
        then
            echo -e "\e[30;48;5;82m ${lines[$i]} \e[0m", "$httpscode"
        else
            echo -e "\e[5m\e[30;48;5;196m ${lines[$i]} \e[0m", "$httpscode"
        fi
        

	done
    
	;;
###############################################3#####################################################
    3)
	read -p "input domain: " domain
        httpcode=$(curl -sL "$domain" -o /dev/null -w "code: %{response_code}")

	if curl -Ls --negotiate "$domain" | grep class > /dev/null
        then
                echo -e "\e[30;48;5;82m $domain \e[0m", "$httpcode"
        else
                echo -e "\e[5m\e30;48;5;196m $domain \e[0m", "$httpcode"
	fi
	;;

	*)
	exit 1
		;;
esac


