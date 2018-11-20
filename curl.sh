#!/bin/bash

echo "check http :1"
echo "check https :2"
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
        httpcode=$(curl -sL http://"${lines[$i]}" -o /dev/null -w "http response code: %{response_code}")
        #http=$(curl -sL http://"${lines[$i]}" | grep title > /dev/null )
       # https=$(curl -sL https://"${lines[$i]}" | grep title > /dev/null )
        
        #if [  "$http" != null ]
        if  curl -sL http://"${lines[$i]}" | grep class > /dev/null  
        then
            echo "live: ${lines[$i]} " ,"$httpcode"
        else
            echo -e "\e[31mdead\e[0m: ${lines[$i]} " ,"$httpcode"
        fi
        

	done
    
	;;

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
        #httpscode=$(curl -sL https://"${lines[$i]}" -o /dev/null -w "https response code: %{response_code}")
        httpscode=$(curl -sL https://"${lines[$i]}" -o /dev/null -w "https response code: %{response_code}")
        https=$(curl -sL https://"${lines[$i]}" | grep title > /dev/null )
       # https=$(curl -sL https://"${lines[$i]}" | grep title > /dev/null )
        
        if curl -sL https://"${lines[$i]}" | grep class > /dev/null 
        then
            echo "live: ${lines[$i]}" ,"$httpscode"
        else
            echo -e "\e[31mdead\e[0m: ${lines[$i]} " ,"$httpscode"
        fi
        

	done
    
	;;

    3)
	read -p "input domain: " domain

	if curl -Ls --negotiate "$domain" | grep title > /dev/null
        then
                echo "URL exists: $domain"
        else
                echo "URL dead: $domain"
	fi
	;;

	*)
	exit 1
		;;
esac


