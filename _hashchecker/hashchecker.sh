#Copyright 2023 Gu4re
#
#This software is licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at:
#
#http://www.apache.org/licenses/LICENSE-2.0
#
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.

#!/bin/bash

# Function that checks the hash
function hashchecker {

	file=$1
	hash_file=$($3 "$file" | awk '{ print $1 }')

	good_hash=$(cat $2 | awk '{ print $1 }')

	if [ "$hash_file" = "$good_hash" ]; then
		echo "All okay! Hashes okay!"
	else
		echo "Boop Boop! Different Hash!"
	fi

	exit 0
}

# Check for arguments
if [ "$#" -ne 3 ]; then
	echo "Error: Bad arguments"
	echo "Correct usage: hashchecker [FILE] [HASH FILE] [HASHTYPE]"
	exit 1
fi

# Global Variables
file=$1
hash_file=$2
hash_function=$3

if [ "$hash_function" = "sha256" ]; then
	if ! echo "$hash_file" | grep -qE '\.sha256$'; then
		echo "Error. Bad hash file. Need ".sha256" file"
		exit 1
	else
		hash_function="sha256sum"
		hashchecker $file $hash_file $hash_function
	fi

elif [ "$hash_function" = "md5" ]; then
	if ! echo "$hash_file" | grep -qE '\.md5$'; then
		echo "Error. Bad hash file. Need ".md5" file"
		exit 1
	else
		hashchecker $file $hash_file $hash_function
	fi
else
	echo "Error. Bad hash function. Only sha256 or md5 is allowed"
fi
