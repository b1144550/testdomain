#!/bin/bash

read -p "input domain: " domain

curl $domain -o /dev/null -w "Response code: %{response_code},\nTime to connect: %{time_connect}\nTotal time: %{time_total}\nHeader size: %{size_header}\n"
