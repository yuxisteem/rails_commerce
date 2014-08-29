class SMSNotifier
  include Rails.application.routes.url_helpers
  def initialize
    @client = SmsClub::AsyncClient.new(
                                    AppConfig.sms_notifier.login,
                                    AppConfig.sms_notifier.password,
                                    from: AppConfig.sms_notifier.from,
                                    transliterate: AppConfig.sms_notifier.transliterate
                                  )
  end

  def sms(message, to: nil)
    return false unless AppConfig.sms_notifier.enabled

    raise ArgumentError, 'Recepient phone number is nil' unless to

    @client.send_async(message, to: to) #if Rails.env.production?

    Rails.logger.info %(
      SMS Sent
      To: #{to}
      Message: #{message}
    )
  end

  def self.method_missing(method_name, *args)
    if instance_methods.include?(method_name)
      new.send(method_name, *args)
    else
      super
    end
  end
end
