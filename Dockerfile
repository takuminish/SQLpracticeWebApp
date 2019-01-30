FROM ruby:2.6.0

RUN apt-get update && \
    apt-get -y install mysql-client && \
    gem install bundler && \
    gem install mysql2 -v '0.5.2' --source 'https://rubygems.org/'

WORKDIR /app
COPY ./Gemfile Gemfile
COPY ./Gemfile Gemfile.lock
RUN bundle install

COPY . /app



