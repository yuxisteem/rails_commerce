class OrderSMSNotifier < SMSNotifier
  def order_recieved(order_id)
  end

  def order_recieved_admin(order_id)
  end

  def notify_user(number)
    sms 'Notify him!', to: number
  end
end