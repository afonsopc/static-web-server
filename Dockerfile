FROM alpine:latest

RUN mkdir /web

RUN apk update && apk upgrade --no-cache
RUN apk add --no-cache lighttpd

RUN echo "server.port = 3000" >> /etc/lighttpd/lighttpd.conf
RUN sed -i 's/var.basedir.*/var.basedir = "\/web"/' /etc/lighttpd/lighttpd.conf
RUN echo 'server.modules += ("mod_rewrite")' >> /etc/lighttpd/lighttpd.conf
RUN echo 'url.rewrite-once = ("^/([^.]+)$" => "/index.html/$1")' >> /etc/lighttpd/lighttpd.conf

CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]