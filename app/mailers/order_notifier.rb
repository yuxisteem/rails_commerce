class OrderNotifier < AsyncMailer
  # Notify Customer that we've recieved new order
  def order_received(order_id)
    @order = Order.find(order_id)
    mail to: @order.user.email
  end

  # Notify Admin that we've recieved new order
  def order_received_admin(order_id)
    @order = Order.find(order_id)
    mail to: User.where(admin: true).pluck(:email)
  end

  # Notify Customer that we've shipped order
  def order_shipped(order_id)
    @order = Order.find(order_id)
    mail to: @order.user.email
  end
end
