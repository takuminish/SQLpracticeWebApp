FROM ruby:2.6.0

RUN apt-get update
RUN apt-get -y install mysql-client

RUN gem install bundler
RUN gem install mysql2 -v '0.5.2' --source 'https://rubygems.org/'

COPY . /app
WORKDIR /app

RUN bundle install
