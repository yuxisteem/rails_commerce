require 'resque/tasks'
task 'resque:setup' => :environment do
  ENV['QUEUE'] ||= '*'
  ENV['BACKGROUND'] ||= 'yes'
  ENV['TERM_CHILD'] ||= '1'
  ENV['PIDFILE'] ||= 'tmp/pids/resque.pid'
end
