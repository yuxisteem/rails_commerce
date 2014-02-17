# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'ecomm'

set :repo_url, 'git@github.com:pavel-d/RailsCommerce.git'
set :branch, ENV['BRANCH'] || 'master'
set :rails_env, ENV['RAILS_ENV'] || 'production'
set :deploy_to, '/home/rails'
set :deploy_via, :remote_cache

set :keep_releases, 2

set :current_release, "#{fetch(:deploy_to)}/current"

set :rvm_ruby_string, 'ruby-2.1.0'

set :rvm_bin_path, '/home/rails/.rvm/bin/rvm'

set :linked_dirs, %w{bin log vendor/bundle public/system}

set :puma_pid_file, "#{fetch(:deploy_to)}/shared/tmp/pids/puma.pid"
set :puma_state_file, "#{fetch(:deploy_to)}/shared/tmp/pids/puma.state"
set :config_file, "#{fetch(:current_release)}/config/puma.rb"

set :puma_cmd, "puma -C #{fetch(:config_file)}"

def bundler
  "#{fetch(:rvm_bin_path)} #{fetch(:rvm_ruby_string)} do bundle exec"
end

def puma_start_cmd
  "cd #{fetch(:current_release)} && #{bundler} pumactl -F #{fetch(:config_file)} -S #{fetch(:puma_state_file)} start"
end

def puma_stop_cmd
  "cd #{fetch(:current_release)} && #{bundler} pumactl -S #{fetch(:puma_state_file)} stop"
end

def puma_restart_cmd
  "cd #{fetch(:current_release)} && #{bundler} pumactl -F #{fetch(:config_file)} -S #{fetch(:puma_state_file)} restart"
end

def config_files
  %w(config.yml database.yml newrelic.yml)
end

namespace :deploy do

  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      execute "#{puma_start_cmd}", :pty => false
    end
  end

  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      execute "#{puma_stop_cmd}"
    end
  end

  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      begin
        execute "#{puma_restart_cmd}"            
      rescue Exception => ex 
        puts "Failed to restart puma: #{ex}\nAssuming not started."
        execute "#{puma_start_cmd}"
      end
    end
  end

  task :symlink_configs do
    on roles(:app), in: :sequence, wait: 5 do  
      config_files.each do |f|
        execute "rm -f #{fetch(:release_path)}/config/#{f} && ln -s ~/shared/config/#{f} #{fetch(:release_path)}/config/#{f}"  
      end
    end
  end

  after :publishing, :restart
  after :updating, 'deploy:symlink_configs'
  after 'deploy:updated', "deploy:assets:precompile"
  after 'deploy:assets:precompile', 'deploy:assets:upload'
  
end