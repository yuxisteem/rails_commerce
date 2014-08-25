class AsyncMailer < ActionMailer::Base
  default from: AppConfig.mailer.default_from
  include Resque::Mailer
end
