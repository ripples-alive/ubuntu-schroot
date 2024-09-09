#!/bin/sh

if [ ! -d /data ]; then
  rsync -a /template/ /data

  echo "root:${ROOT_PASSWORD}" | chpasswd
fi

exec schroot -c ubuntu -d / /entrypoint-schroot.sh "$@"
