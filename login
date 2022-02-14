#!/bin/bash
# FLAG: headupcommands

input="$1"
arg=${@:2};
executionmode=`ps -o stat= -p $$`

cd ~/.password-store
result=$(tree -f -i -Q | grep -i "$input")
result=$(echo "$result" | head -1)
result=${result[0]}
result=${result//.gpg/};
result=${result//"./"/};
result=${result//\"/};
export password_name=${result#*/}
export password_file=$result
content=$(pass show "$result")
passwd=$(echo "$content" | head -1)
login=$(echo "$content" | grep -i "login:") 
url=$(echo "$content" | grep -i "url:");
url=${url//url: /};
url_sftp=$(echo "$url" | grep -i "sftp:");
url_ssh=$(echo "$url" | grep -i "ssh:");
url_https=$(echo "$url" | grep -i "https:");

open_nothing() {
	echo "Not opening '$1' because this is not supported!"
}
 
open_firefox() {
	echo "opening url '$url' in firefox"
    
	firefox $url
}

open_sftp() {
	if ! [ -z $(which sshfs) ]
	then
		local connstring=${1//sftp:/};
		connstring=${connstring//\//};
		echo "Connecting to remote file system using sshfs..."
		# see https://en.wikibooks.org/wiki/OpenSSH/Cookbook/File_Transfer_with_SFTP#sshfs(1)_-_SFTP_File_Transfer_Via_Local_Folders
		test -d ~/headupcommands_remotedirs || mkdir --mode 700 ~/headupcommands_remotedirs
		test -d ~/headupcommands_remotedirs/${password_name} || mkdir --mode 700 ~/headupcommands_remotedirs/${password_name}
		echo $connstring
		#fusermount -u ~/headupcommands_remotedirs/${password_name}
		sshfs ${connstring}:/ ~/headupcommands_remotedirs/${password_name} -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3
		xdg-open ~/headupcommands_remotedirs/${password_name}
	elif ! [ -z $(which gio) ]
	then
		echo "Connecting to remote file system using gio..."
		gio mount -u "$1"
		gio mount "$1"
	elif ! [ -z $(which gvfs-mount) ]
	then
		echo "Connecting to remote file system using gvfs-mount..."
		gvfs-mount "$1"
	else
		echo "Cannot find appropriate method myself, handling over to xdg-open..."
		xdg-open "$1"
	fi
}

ssh_serversupportsauthpassword() {
	# code taken from https://serverfault.com/questions/938149/how-to-test-if-ssh-server-allows-passwords
	local res=`ssh -v -n -o Batchmode=yes -o StrictHostKeyChecking=no -o UserKnownHostsFile "$1" 2>&1 | grep "Authentications that can continue" | head -1`
	res=`echo "$res" | grep "password"`
	echo "$res"
	if ! [[ -z "$res" ]]; # password authentication allowed
	then
		true
		return
	fi
	false
	return
}

open_ssh() {
	echo "Remote server: $1"
	#local old_IFS="$IFS"
	#IFS=$''
	local host=`echo "$1"`
	
	echo "checking authentication methods..."
# 	echo $host
	local regexp="(.*?)\/$"
	if [[ $host =~ $regexp ]]; # removing '/' if it is the last char
	then
		host=${BASH_REMATCH[1]}
# 		echo $host
	fi;
# 	echo $host
	
	if [[ `ssh_serversupportsauthpassword $host` ]]; # password authentication allowed
	then
		echo -e "\033[0;31mThe server allows password authentication. Password authentication is considered bad practice since mainstream loves to use easy-to-guess passwords. Your administrator should consider disabling password authentication.\033[0;m"
		export SSH_ASKPASS="/home/soren/headupcommands/sshaskpasstopass"
		export DISPLAY="foo"
		export SSH_ASKPASS_REQUIRE="force"
		echo -e "\033[1;31mThis script now uses SSH password authentication but using this method is not as secure as using keys!\033[0;m"
	fi;
	
	if [ -z "$arg" ];
	then
		echo "-------------------------------------------------------"
		ssh $host
	else
		echo "Remote command: $arg"
		echo "-------------------------------------------------------"
	
		ssh $host "$arg"
		exitcode="$?"
		echo 
		echo "Remote command exited with code '$exitcode'"
		exit $exitcode
	fi;
}

if [[ "$executionmode" == "S" ]]; # script has been started in the background
then
    echo "background execution mode"
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
	echo "foreground execution mode"
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
