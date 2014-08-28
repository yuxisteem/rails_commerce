class SMSNotifier
  def initialize
    @client = SmsClub::AsyncClient.new(
                                    AppConfig.sms_notifier.login,
                                    AppConfig.sms_notifier.password,
                                    from: AppConfig.sms_notifier.from,
                                    transliterate: AppConfig.sms_notifier.transliterate
                                  )
  end

  def sms(message, to: nil, from: nil, transliterate: false)
    return false unless AppConfig.sms_notifier.enabled

    raise ArgumentError, 'Recepient phone number is nil' unless to
    @client.send_async(message, to: to, from: from, transliterate: transliterate)
  end

  def self.method_missing(method_name, *args)
    if instance_methods.include?(method_name)
      new(method_name, *args).send(method_name, args)
    else
      super
    end
  end
end
