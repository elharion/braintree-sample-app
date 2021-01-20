FROM ruby:2.7.2

ENV RUBY_VERSION=2.7.2
ENV BUNDLER_VERSION=2.1.4
ENV LOAD_PATH=/app/

RUN gem install bundler --version "$BUNDLER_VERSION"

COPY ./source/Gemfile ./source/Gemfile.lock /app/
ADD . /app

WORKDIR /app

RUN set -ex  && \
    cd /app  && \
    mkdir -p /var/bundle && \
    bundle config set path '/var/bundle' && \
    bundle install
