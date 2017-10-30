# Repository to mirror. Should be address suitable for rsync.
src=rsync://rsync.alpinelinux.org/alpine

# Intermediate directory. Data will be downloaded here and then added to
# IPFS. This directory should be somewhat persistent to allow incremental
# rsync downloads.
dest=./alpine

# Name of IPFS key to be used for publishing.
key=alpine

# What to include in mirror. Elements of this array will be passed to rsync
# with --include flag each.
includes=(
	edge
	*/main/
	*/community/
	*/testing/
	*/*/x86_64/***
	*/*/armhf/***
)
