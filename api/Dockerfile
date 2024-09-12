FROM ruby:3.1.2-alpine

RUN apk update && apk add --no-cache \
  nodejs \
  postgresql-client \
  gcompat \
  build-base \
  postgresql \
  postgresql-dev \
  bash

WORKDIR /api

COPY Gemfile* .

RUN bundle install

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
