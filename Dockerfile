ARG APP_HOME=/app

# --- Builder ---
FROM node:alpine AS builder

LABEL stage=intermediate

ARG APP_HOME

RUN mkdir $APP_HOME

WORKDIR $APP_HOME

ADD . $APP_HOME

RUN yarn install && yarn build

# --- Release image ---
FROM nginx:stable-alpine

ARG APP_HOME

COPY conf/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder $APP_HOME/dist/ /usr/share/nginx/html/
