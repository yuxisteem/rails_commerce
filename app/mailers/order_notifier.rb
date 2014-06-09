class OrderNotifier < AsyncMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.order_received.subject
  #
  def order_received(order_id)
    @order = Order.find(order_id)
    mail to: @order.user.email
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.order_shipped.subject
  #
  def order_shipped(order_id)
    @order = Order.find(order_id)
    mail to: @order.user.email
  end
end
