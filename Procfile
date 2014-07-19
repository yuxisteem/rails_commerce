web:    bundle exec unicorn_rails -c ~/current/config/unicorn.rb -E production
worker: bundle exec rake resque:work QUEUE=* RAILS_ENV=production