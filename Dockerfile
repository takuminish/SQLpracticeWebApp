FROM ruby:2.6.0

RUN apt-get update
RUN apt-get -y install mysql-client

RUN gem install bundler
RUN gem install mysql2 -v '0.5.2' --source 'https://rubygems.org/'

WORKDIR /app
COPY ./Gemfile Gemfile
COPY ./Gemfile Gemfile.lock
RUN bundle install

COPY . /app



