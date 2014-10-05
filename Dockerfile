FROM rails:onbuild

CMD cp config/config.yml.sample config/config.yml
CMD rake db:schema:load
CMD rake db:demo
CMD rails s
