#!/bin/bash

input="$1"
arg=${@:2};
executionmode=`ps -o stat= -p $$`
echo $executionmode

open_nothing() {
	echo "Not opening '$1' because this is not supported!"
}

open_firefox() {
	echo "opening url '$url' in firefox"
    
	firefox $url
}

open_sftp() {
    xdg-open "$1"
}

open_ssh() {
	echo "Remote server: $1"
	
	if [ -z "$arg" ];
	then
		echo "-------------------------------------------------------"
		ssh $1
	else
		echo "Remote command: $arg"
		echo "-------------------------------------------------------"
	
		ssh $1 "$arg"
		exitcode="$?"
		echo 
		echo "Remote command exited with code '$exitcode'."
	fi;
}

cd ~/.password-store
result=$(tree -f -i -Q | grep -i "$input")
result=$(echo "$result" | head -1)
result=${result[0]}
result=${result//.gpg/};
result=${result//"./"/};
result=${result//\"/};
content=$(pass show "$result")
url=$(echo "$content" | grep -i "url");
url=${url//url: /};
url_sftp=$(echo "$url" | grep -i "sftp:");
url_ssh=$(echo "$url" | grep -i "ssh:");
url_https=$(echo "$url" | grep -i "https:");

if [[ "$executionmode" == "S" ]]; # script has been started in the background
then
    
	if ! [ -z "$url_sftp" ];
	then
		open_sftp "$url_sftp"
	elif ! [ -z "$url_sftp" ] && ! [ -z "$arg" ]; # and no second up to the last argument given
	then
		url_sftp=${url_sftp//sftp:/ssh:};
		open_ssh "$url_sftp"
	elif ! [ -z "$url_ssh" ];
	then
		url_ssh=${url_ssh//ssh:/sftp:};
		open_sftp "$url_ssh"
	elif ! [ -z "$url_https" ];
	then
		open_firefox "$url_https"
	else
		open_nothing
	fi
	echo "You can close this window"
    exit 0
    
else # script has been started in the foreground
    
    if ! [ -z "$url_ssh" ];
	then
		open_ssh "$url_ssh"
	elif ! [ -z "$url_sftp" ];
	then
		url_sftp=${url_sftp//sftp:/ssh:};
		open_ssh "$url_sftp"
	elif ! [ -z "$url_https" ];
	then
		open_firefox "$url_https"
	else
		open_nothing
	fi
	echo "You can close this window"
    exit 0


fi
