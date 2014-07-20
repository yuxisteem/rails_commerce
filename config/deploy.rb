# config valid only for Capistrano 3.2.1
lock '3.2.1'

set :application, 'ecomm'

set :repo_url, 'git@github.com:pavel-d/RailsCommerce.git'
set :branch, ENV['BRANCH'] || 'master'
set :rails_env, ENV['RAILS_ENV'] || 'production'

set :deploy_to, '~'
set :deploy_via, :remote_cache

set :copy_exclude, ['.git']

set :rails_env, 'production'

set :current_release, "#{fetch(:deploy_to)}/current"

set :rvm_ruby_string, 'ruby-2.1.2'

# set :rvm_bin_path, '~/.rvm/bin/rvm'

set :linked_dirs, %w(bin log vendor/bundle public/system public/assets)
set :linked_files, %w(config/config.yml config/database.yml)

set :unicorn_pid_file, "#{fetch(:deploy_to)}/shared/tmp/pids/unicorn.pid"

def bundler
  "#{fetch(:rvm_bin_path)} #{fetch(:rvm_ruby_string)} do bundle exec"
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
        execute 'sudo service ecomm-worker restart'
      end
    end
  end

  after :updating, 'deploy:assets:precompile'
  after 'deploy:assets:precompile', 'deploy:assets:upload'
  after :publishing, :restart
  after :restart, 'deploy:resque:restart'
end
