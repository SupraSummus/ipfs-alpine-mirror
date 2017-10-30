#!/bin/sh
apkindex="APKINDEX.tar.gz"

function apktime {
	if ipfs object stat -- $1$apkindex > /dev/null 2>&1; then
		echo -ne $1$apkindex"\t"
		ipfs cat -- $1$apkindex | tar -ztv | grep APKINDEX | awk '{print $4" "$5}'
	else
		while read -r line; do
			apktime $1$(echo $line | awk '{print $3}')
		done <<< $(ipfs ls -- $1)
	fi
}

for addr in $(cat repository); do
	apktime $addr/
done
