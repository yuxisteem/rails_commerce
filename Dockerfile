FROM ruby:2.1.3

RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

ADD . /usr/src/app

ADD Gemfile /usr/src/app/
ADD Gemfile.lock /usr/src/app/
RUN bundle install --system

RUN cp config/config.yml.sample config/config.yml
RUN rake db:schema:load
RUN rake db:demo

EXPOSE 3000
CMD rails s
