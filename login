#!/bin/bash

cd ~/.password-store
result=$(tree -f -i -Q | grep -i "$1")
result=$(echo "$result" | head -1)
echo $result
result=${result[0]}
result=${result//.gpg/};
result=${result//"./"/};
result=${result//\"/};
result=$(pass show "$result" | grep -i "url");
result=${result//url: /};

firefox $result

echo "You can close this window"
