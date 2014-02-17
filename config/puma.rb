deploy_to = '/home/rails'


pidfile "#{deploy_to}/shared/tmp/pids/puma.pid"
state_path "#{deploy_to}/shared/tmp/pids/puma.state"
bind "unix://#{deploy_to}/shared/tmp/sockets/puma.sock"
stdout_redirect "#{deploy_to}/shared/log/puma.log", "#{deploy_to}/shared/log/puma_error.log", true

environment ENV['RAILS_ENV'] || 'production'

threads 0, 16
#workers 1
preload_app!

on_worker_boot do
	ActiveSupport.on_load(:active_record) do
	ActiveRecord::Base.establish_connection
	end
end

on_restart do
	puts 'On restart...'
	ENV["BUNDLE_GEMFILE"] = "#{deploy_to}/current/Gemfile"
end
