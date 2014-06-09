class AsyncMailer < ActionMailer::Base
  default from: AppConfig['mailer']['from_address']
  include Resque::Mailer
end
