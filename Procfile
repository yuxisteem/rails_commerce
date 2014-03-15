web:    bundle exec unicorn_rails -c /home/rails/current/config/unicorn.rb -E production
worker: RAILS_ENV=production bundle exec rake resque:work QUEUE=*