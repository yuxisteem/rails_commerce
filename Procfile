web:    bundle exec unicorn_rails -c ~/config/unicorn.rb -E production
worker: bundle exec rake resque:work QUEUE=* RAILS_ENV=production TERM_CHILD=1