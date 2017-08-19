FROM alpine:latest as build

RUN apk --update add curl

ARG CADDY_VERSION
ENV CADDY_DL "https://github.com/mholt/caddy/releases/download/v${CADDY_VERSION}/caddy_v${CADDY_VERSION}_linux_amd64.tar.gz"
RUN curl -fsSL ${CADDY_DL} | tar xvz -C /usr/local/bin

FROM alpine:latest
COPY --from=build /usr/local/bin/caddy /caddy
EXPOSE 8080
RUN mkdir -p /config
ENTRYPOINT ["/caddy"]
