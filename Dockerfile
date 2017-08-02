FROM alpine:latest
MAINTAINER "Joel Chen <joelchen@msn.com>"
WORKDIR /srv

LABEL version="0.10.6" architecture="amd64"
ARG plugins=
RUN apk add --no-cache tar curl
RUN curl --silent --show-error --fail --location \
      --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://caddyserver.com/download/linux/amd64?plugins=${plugins}" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy \
 && chmod 0755 /usr/bin/caddy \
 && /usr/bin/caddy -version
EXPOSE 80 443 2015
VOLUME /root/.caddy
COPY Caddyfile /etc/Caddyfile
ENTRYPOINT ["/usr/bin/caddy"]
CMD ["--conf", "/etc/Caddyfile", "--log", "stdout"]