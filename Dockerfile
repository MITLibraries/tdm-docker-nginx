FROM nginx

# python and curl needed in startup.sh
RUN apt-get update && \
    apt-get install --no-install-recommends --no-install-suggests -y \
        python3 \
        curl

COPY proxy.tmpl /etc/nginx/conf.d/proxy.tmpl
COPY startup.sh /etc/nginx/startup.sh
RUN chmod +x /etc/nginx/startup.sh

ENTRYPOINT ["/etc/nginx/startup.sh"]

CMD ["nginx", "-g", "daemon off;"]
