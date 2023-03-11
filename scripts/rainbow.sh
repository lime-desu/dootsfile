#!/bin/bash
# not really a rainbow colors hehe

red="$(tput setaf 1)"
grn="$(tput setaf 2)"
ylw="$(tput setaf 3)"
blu="$(tput setaf 4)"
mgn="$(tput setaf 5)"
cyn="$(tput setaf 6)"

colors=("${ylw}" "${grn}" "${cyn}" "${blu}" "${mgn}" "${red}")
rst="$(tput sgr0)"
bld="$(tput bold)"

echo -n "Enter a message: "
read message

for ((i = 0; i < ${#message}; i++)); do
	color=${colors[$((i % 6))]}
	printf '%s%s' "$color" "${message:$i:1}"
done
printf "$none\n"
