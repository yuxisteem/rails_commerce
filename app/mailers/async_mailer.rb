class AsyncMailer < ActionMailer::Base
  default from: AppConfig.mailer.address
  include Resque::Mailer
end
