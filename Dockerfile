FROM ruby:2.6.0

RUN gem install bundler
RUN gem install mysql2 -v '0.5.2' --source 'https://rubygems.org/'

COPY . /app
WORKDIR /app

RUN bundle install