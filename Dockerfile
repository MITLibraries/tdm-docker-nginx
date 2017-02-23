FROM nginx

COPY proxy.tmpl /etc/nginx/conf.d/proxy.tmpl
COPY startup.sh /etc/nginx/startup.sh
RUN chmod +x /etc/nginx/startup.sh

ENTRYPOINT ["/etc/nginx/startup.sh"]

CMD ["nginx", "-g", "daemon off;"]
