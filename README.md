Alpine Linux package repository on IPFS
=======================================

This mirror is partial. Contains edge release; main, community, testing
repos for architectures x86_64 and armhf.

Mirror is updated daily.

IPNS names are listed in `repository` file.

Check repository status
-----------------------

You'll need IPFS that is online.

Run `./apktime.sh`.

Mirror setup
------------

Dependencies
 * rsync
 * IPFS (daemonized)

First generate alpine key. Under this key repository will be published. For example:

    ipfs key gen --type rsa --size 4096 alpine

Then run `./mirror.sh`. Your IPNS name will be added to `repository` file.

Optionally you can setup cron to periodicaly do the job. For example:

    0 3 * * * cd /path/to/ipfs-alpine-mirror && ./mirror.sh
