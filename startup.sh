#!/usr/bin/env bash
set -e

if [ "$1" = 'nginx' ]; then
  echo "$FEDORA_USER:$FEDORA_PASS" > /etc/nginx/htpasswd
  envsubst < /etc/nginx/conf.d/proxy.tmpl > /etc/nginx/conf.d/default.conf
fi

exec "$@"
