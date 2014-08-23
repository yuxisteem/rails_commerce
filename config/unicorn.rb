worker_processes 1

preload_app true

timeout 30

# Path to socket should be absolute
listen '/srv/rails_commerce/shared/tmp/sockets/unicorn.sock', backlog: 2048

stdout_path 'log/unicorn.log'
stderr_path 'log/unicorn_error.log'

pid_file = 'tmp/pids/unicorn.pid'
pid pid_file

# http://www.rubyenterpriseedition.com/faq.html#adapt_apps_for_cow
GC.copy_on_write_friendly = true if GC.respond_to?(:copy_on_write_friendly=)

before_exec do |_server|
  ENV['BUNDLE_GEMFILE'] = File.expand_path('Gemfile')
end

before_fork do |server, _worker|
  ##
  # When sent a USR2, Unicorn will suffix its pidfile with .oldbin and
  # immediately start loading up a new version of itself (loaded with a new
  # version of our app). When this new Unicorn is completely loaded
  # it will begin spawning workers. The first worker spawned will check to
  # see if an .oldbin pidfile exists. If so, this means we've just booted up
  # a new Unicorn and need to tell the old one that it can now die. To do so
  # we send it a QUIT.
  #
  # Using this method we get 0 downtime deploys.

  ActiveRecord::Base.connection.disconnect!

  old_pid = pid_file
  if File.exist?(old_pid) && server.pid != old_pid
    begin
      Process.kill('QUIT', File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      puts 'someone else did our job for us'
    end
  end
end

after_fork do |_server, _worker|
  ##
  # Unicorn master loads the app then forks off workers - because of the way
  # Unix forking works, we need to make sure we aren't using any of the parent's
  # sockets, e.g. db connection
  ActiveRecord::Base.establish_connection
end
