require 'resque/tasks'
task 'resque:setup' => :environment do
   ENV['QUEUE'] ||= '*'
   ENV['TERM_CHILD'] ||= '1'
   ENV['PIDFILE'] ||= 'tmp/pids/resque.pid'
   # ENV['BACKGROUND'] ||= 'yes'
end
