require 'resque/tasks'
task 'resque:setup' => :environment do
  ENV['QUEUE'] ||= '*'
  ENV['TERM_CHILD'] ||= '1'
end
