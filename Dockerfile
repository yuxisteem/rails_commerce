FROM ruby:2.2.0

RUN apt-get update && apt-get install -y nodejs build-essential libpq-dev --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /srv/app

WORKDIR /srv/app

ADD . /srv/app

ADD Gemfile /srv/app/
ADD Gemfile.lock /srv/app/
RUN bundle install --system

RUN cp config/config.yml.sample config/config.yml
RUN rake db:schema:load
RUN rake db:demo

EXPOSE 3000
CMD rails s
