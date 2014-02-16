# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'ecomm'

set :repo_url, 'git@github.com:pavel-d/RailsCommerce.git'
set :branch, ENV['BRANCH'] || 'master'
set :deploy_to, '/home/rails'
set :deploy_via, :remote_cache

set :current_release, "#{fetch(:deploy_to)}/current"

set :rvm_ruby_string, 'ruby-2.1.0'

set :rvm_bin_path, '/home/rails/.rvm/bin/rvm'

set :rails_env, "production"

set :linked_dirs, %w{bin log vendor/bundle public/system}

set :puma_pid_file, "#{fetch(:deploy_to)}/shared/tmp/pids/puma.pid"
set :puma_state_file, "#{fetch(:deploy_to)}/shared/tmp/pids/puma.state"
set :config_file, "#{fetch(:current_release)}/config/puma.rb"

set :puma_cmd, "puma -C #{fetch(:config_file)}"

def bundler
  "cd #{fetch(:current_release)} && #{fetch(:rvm_bin_path)} #{fetch(:rvm_ruby_string)} do bundle exec"
end

def puma_start_cmd
  "#{bundler} #{fetch(:puma_cmd)}"
end

def puma_stop_cmd
  "kill `cat #{fetch(:puma_pid_file)}`"
end

def puma_restart_cmd
  "#{bundler} pumactl -F #{fetch(:config_file)} -S #{fetch(:puma_state_file)} restart"
end


namespace :deploy do

  after :publishing, :restart

  after :updating, 'deploy:update_configs' do
    on roles(:app), in: :sequence, wait: 5 do
      execute "rm -f #{fetch(:release_path)}/config/config.yml && ln -s ~/shared/config/config.yml #{fetch(:release_path)}/config/config.yml"
      execute "rm -f #{fetch(:release_path)}/config/database.yml && ln -s ~/shared/config/database.yml #{fetch(:release_path)}/config/database.yml"
      execute "rm -f #{fetch(:release_path)}/config/newrelic.yml && ln -s ~/shared/config/newrelic.yml #{fetch(:release_path)}/config/newrelic.yml"
    end
  end




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

  task :test do
    on roles(:app), in: :sequence, wait: 5 do
      puts "#{fetch(:branch)}"
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

end


namespace :foreman do
  desc "Export the Procfile to Ubuntu's upstart scripts"
  task :export, :roles => :app do
    run "cd #{fetch(:current_release)} && #{sudo} foreman export upstart /etc/init -a #{fetch(:app_name)} -u rails"
  end

  desc "Start the application services"
  task :start, :roles => :app do
    run "service #{fetch(:app_name)} start"
  end

  desc "Stop the application services"
  task :stop, :roles => :app do
    run "service #{fetch(:app_name)} stop"
  end

  desc "Restart the application services"
  task :restart, :roles => :app do
    run "service #{fetch(:app_name)} start || service #{app_name} restart"
  end
end
