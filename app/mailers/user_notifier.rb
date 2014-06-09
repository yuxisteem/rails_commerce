class UserNotifier < AsyncMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.registered.subject
  #
  def registered(user_id)
    @user = User.find(user_id)
    mail to: @user.email
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.account_created.subject
  #
  def account_created(user_id, password)
    @user = User.find(user_id)
    @password = password
    mail to: @user.email
  end
end
