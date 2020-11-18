FROM ruby:2.6.5-alpine

RUN apk add --update --no-cache \
    build-base \
    gmp-dev \
    libxslt-dev \
    libxml2-dev \
    mariadb-dev \
    tzdata \
    yarn \
    imagemagick6-dev \
    bash

WORKDIR /myapp
ENV TZ=Asia/Tokyo

COPY Gemfile .
COPY Gemfile.lock .

COPY package.json .
COPY yarn.lock .

RUN gem install bundler -v 2.1.2 && bundle update --bundler && bundle install
RUN yarn install --check-files

COPY . /myapp
