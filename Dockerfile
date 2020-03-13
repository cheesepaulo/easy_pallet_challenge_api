FROM ruby:2.6.5-slim

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
      build-essential nodejs libpq-dev git-all

ENV INSTALL_PATH /easy_pallet_challenge_api

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile ./

ENV BUNDLE_PATH /app-gems

COPY . .
