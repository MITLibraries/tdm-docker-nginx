#!/usr/bin/env bash
set -e

if [ "$1" = 'nginx' ]; then
  TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
  CURL_OPTS=(
    -s
    --cacert "/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
    -H "Authorization: Bearer "${TOKEN}""
  )
  PYCODE="import json, sys; \
    print(json.load(sys.stdin)['status']['loadBalancer']['ingress'][0]['ip'])"
  export NGINX_EXTERNAL_IP="$(
    curl "${CURL_OPTS[@]}" \
      https://kubernetes/api/v1/namespaces/default/services/nginx-proxy |
    python3 -c "${PYCODE}"
  )"
  echo "${FEDORA_USER}:${FEDORA_PASS}" > /etc/nginx/htpasswd
  envsubst < /etc/nginx/conf.d/proxy.tmpl > /etc/nginx/conf.d/default.conf
fi

exec "$@"
