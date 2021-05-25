#!/bin/bash

input="$1"

open_firefox() {
    url=${1//url: /};
    
    echo "opening url '$url' in firefox"
    
    firefox $url
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
ssh=$(echo "$content" | grep -i "ssh");
if ! [ -z "$url" ];
then
    open_firefox "$url"
    echo "You can close this window"
fi

if ! [ -z "$ssh" ];
then
    remote_command=${@:2};
    remote "$input" "$remote_command";
fi;
