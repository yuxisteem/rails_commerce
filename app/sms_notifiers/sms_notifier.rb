class SMSNotifier
  def initialize(method_name=nil, *args)
    @client = SmsClub::Client.new(
                                    AppConfig.sms_notifier.login,
                                    AppConfig.sms_notifier.password,
                                    from: AppConfig.sms_notifier.from,
                                    transliterate: AppConfig.sms_notifier.transliterate
                                  )
  end

  def sms(message, to: nil, from: nil, transliterate: false)
    raise ArgumentError, 'Recepient phone number is nil' unless to
    @client.send_many(message, to: to, from: from, transliterate: transliterate)
  end

  protected

  def self.method_missing(method_name, *args)
   if instance_methods.include?(method_name)
      new(method_name, *args).send(method_name, args)
    else
      super
    end
  end
end