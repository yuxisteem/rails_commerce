# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'ecomm'

set :repo_url, 'git@github.com:pavel-d/RailsCommerce.git'
set :branch, ENV['BRANCH'] || 'master'
set :rails_env, ENV['RAILS_ENV'] || 'production'
set :deploy_to, '/home/rails'
set :deploy_via, :remote_cache
set :copy_exclude, [ '.git' ]

set :rails_env, 'production'

set :keep_releases, 2

set :current_release, "#{fetch(:deploy_to)}/current"

set :rvm_ruby_string, 'ruby-2.1.0'

set :rvm_bin_path, '/home/rails/.rvm/bin/rvm'

set :linked_dirs, %w{bin log vendor/bundle public/system public/assets}
set :linked_files, %w(config/config.yml config/database.yml config/newrelic.yml)

set :unicorn_pid_file, "#{fetch(:deploy_to)}/shared/tmp/pids/unicorn.pid"
set :config_file, "#{release_path}/config/unicorn.rb"

set :unicorn_cmd, "unicorn -C #{fetch(:config_file)}"

def bundler
  "#{fetch(:rvm_bin_path)} #{fetch(:rvm_ruby_string)} do bundle exec"
end

def unicorn_start_cmd
  "cd #{release_path} && #{bundler} unicorn_rails -c #{fetch(:config_file)} -E production -D"
end

def unicorn_stop_cmd
  "kill `cat #{fetch(:unicorn_pid_file)}` || echo 'Unicorn is not runing'"
end

def unicorn_restart_cmd
  "kill -USR2 `cat #{fetch(:unicorn_pid_file)}` || echo 'Unicorn is not runing'"
end

namespace :deploy do

  task :restart do
    on roles(:app), in: :parallel do
      execute "#{unicorn_restart_cmd}"            
    end
  end

  namespace :resque do
    task :restart do
      on roles(:app), in: :parallel do
        execute "sudo service ecomm restart"
      end
    end
  end

  after :publishing, :restart
  after :restart, "deploy:resque:restart"
  after :updating, "deploy:assets:precompile"
  after "deploy:assets:precompile", "deploy:assets:upload"
end