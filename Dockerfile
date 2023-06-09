# ---- Build Stage ----
FROM hexpm/elixir:1.14.0-erlang-24.1.7-alpine-3.14.2 AS builder
RUN apk add --no-cache --update busybox-extras build-base git python3 bash openssl curl make g++ npm yarn





WORKDIR /app


LABEL app="fun-events-builder"

ENV MIX_ENV=prod \
    LANG=C.UTF-8


RUN mix local.hex --force && \
    mix local.rebar --force

COPY mix.exs mix.lock ./
RUN mix deps.get
RUN mkdir config


COPY config/config.exs config/${MIX_ENV}.exs config/
RUN mix deps.compile

COPY apps ./apps
COPY mix.exs .
COPY mix.lock .

COPY apps/landing/mix.exs apps/landing/mix.exs 
COPY apps/fun_events/mix.exs apps/fun_events/mix.exs
COPY apps/fun_events_web/mix.exs apps/fun_events_web/mix.exs

COPY apps/landing/priv apps/landing/priv
COPY apps/fun_events_web/priv apps/fun_events_web/priv

COPY apps/landing/assets apps/landing/assets
COPY apps/fun_events_web/assets apps/fun_events_web/assets


RUN cd apps/fun_events_web && mix deps.get
RUN cd apps/landing && mix deps.get
RUN cd apps/fun_events_web && mix assets.deploy

RUN cd apps/landing && mix assets.deploy

RUN mix compile

COPY config/runtime.exs config/
RUN mix release



# ---- Application Stage ----
FROM alpine:3.16
RUN apk add --no-cache --update busybox-extras bash openssl curl libstdc++ ncurses-libs



    
ARG GIT_COMMIT
ARG VERSION

LABEL app="fun_events"
LABEL GIT_COMMIT=$GIT_COMMIT
LABEL VERSION=$VERSION

WORKDIR /app

COPY --from=builder /app/_build .

# CMD ["/app/prod/rel/reservator/bin/reservator", "start"]