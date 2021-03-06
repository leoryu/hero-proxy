FROM alpine:latest

ENV VER=2.8.0
ENV METHOD=chacha20
ENV PASSWORD=123456
ENV PORT=8080

RUN apk add --no-cache curl \
  && curl -sL https://github.com/ginuerzh/gost/releases/download/v${VER}/gost_${VER}_linux_amd64.tar.gz | tar zx \
  && chmod +x gost_${VER}_linux_amd64/gost

CMD /gost_${VER}_linux_amd64/gost -L=ss+mws://$METHOD:$PASSWORD@:$PORT?dns=8.8.8.8,1.1.1.1:53/tcp,1.1.1.1:853/tls,https://1.0.0.1/dns-query