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

set :linked_dirs, %w{bin log vendor/bundle public/system}
set :linked_files, %w(config/config.yml config/database.yml config/newrelic.yml)

set :puma_pid_file, "#{fetch(:deploy_to)}/shared/tmp/pids/puma.pid"
set :puma_state_file, "#{fetch(:deploy_to)}/shared/tmp/pids/puma.state"
set :config_file, "#{release_path}/config/puma.rb"

set :puma_cmd, "puma -C #{fetch(:config_file)}"

def bundler
  "#{fetch(:rvm_bin_path)} #{fetch(:rvm_ruby_string)} do bundle exec"
end

def puma_start_cmd
  "cd #{release_path} && #{bundler} pumactl -F #{fetch(:config_file)} -S #{fetch(:puma_state_file)} start"
end

def puma_stop_cmd
  "cd #{release_path} && #{bundler} pumactl -S #{fetch(:puma_state_file)} stop"
end

def puma_restart_cmd
  "cd #{release_path} && #{bundler} pumactl -F #{fetch(:config_file)} -S #{fetch(:puma_state_file)} restart"
end

def linked_dirs
  %w(bin log vendor/bundle public/system)
end

def linked_files
  %w(config/config.yml config/database.yml config/newrelic.yml)
end

namespace :deploy do

  # task :start do
  #   on roles(:app), in: :sequence, wait: 5 do
  #     execute "#{puma_start_cmd}", :pty => false
  #   end
  # end

  # task :stop do
  #   on roles(:app), in: :sequence, wait: 5 do
  #     execute "#{puma_stop_cmd}"
  #   end
  # end

  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      begin
        execute "#{puma_restart_cmd}"            
      rescue Exception => ex 
        puts "Failed to restart puma: #{ex}\nAssuming not started."
      end
    end
  end

  task :link_files do
    on roles(:all), in: :sequence, wait: 5 do
      execute linked_files.map {|file| "rm -f #{release_path}/#{file} && ln -s ~/shared/#{file} #{release_path}/#{file}"}.join(';')
    end
  end

  task :link_dirs do
    on roles(:all), in: :sequence, wait: 5 do  
      execute linked_files.map {|dir| "rm -f #{release_path}/#{dir} && ln -s ~/shared/#{dir} #{release_path}/#{dir}"}.join(';')
    end
  end

  after :publishing, :restart
  after 'deploy:updating', "deploy:link_files"
  after 'deploy:updating', "deploy:link_dirs"
  after 'deploy:updated', "deploy:assets:precompile"
  after 'deploy:assets:precompile', 'deploy:assets:upload'

end