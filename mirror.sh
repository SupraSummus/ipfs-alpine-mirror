#!/bin/sh

# make sure we never run 2 rsync at the same time
lockfile="/tmp/alpine-mirror.lock"
if [ -z "$flock" ] ; then
  exec env flock=1 flock -n $lockfile "$0" "$@"
fi

src=rsync://rsync.alpinelinux.org/alpine
dest=alpine
key=alpine
name=$(ipfs key list -l | grep $key | cut -d ' ' -f 1)

mkdir -p "$dest"
rsync \
	--archive \
	--update \
	--hard-links \
	--delete \
	--delete-after \
	--delay-updates \
	--timeout=600 \
	--progress \
	--include 'edge' \
	--include '*/main/' \
	--include '*/community/' \
	--include '*/testing/' \
	--include '*/*/x86_64/***' \
	--include '*/*/armhf/***' \
	--exclude '*' \
	"$src" "$dest"

pre=$(ipfs name resolve -n -- $name | cut -d / -f 3)
echo "old mirror is $pre"
post=$(ipfs add -r -p -Q -- $dest)
echo "new mirror is $post"

if [ "$pre" != "$post" ]; then
	echo "publishing new mirror to key $key (peerid $name)"
	ipfs name publish --key $key -- $post
	echo "/ipns/$name" >> repository
	sort -u -o repository repository

	echo "removing old pin"
	ipfs pin rm -- $pre
fi


