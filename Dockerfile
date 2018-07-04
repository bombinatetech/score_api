FROM elixir:alpine
ARG APP_NAME=score_api
ENV MIX_ENV=staging REPLACE_OS_VARS=true TERM=xterm
WORKDIR /opt/app
RUN apk update \
    && apk --no-cache --update add git \
    make \
    build-base  \
    curl \
    && mix local.rebar --force \
    && mix local.hex --force
COPY . .
RUN mix do deps.get, deps.compile, compile
RUN MIX_ENV=staging mix release --env=staging --verbose \
    && mv _build/staging/rel/${APP_NAME} /opt/release \
    && mv /opt/release/bin/${APP_NAME} /opt/release/bin/start_server
FROM alpine:latest
RUN apk update && apk --no-cache --update add bash openssl-dev
ENV PORT=8090 MIX_ENV=staging REPLACE_OS_VARS=true
WORKDIR /opt/app
EXPOSE ${PORT}
COPY --from=0 /opt/release .
CMD ["/opt/app/bin/start_server","foreground"]