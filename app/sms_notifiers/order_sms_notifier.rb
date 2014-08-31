class OrderSMSNotifier < SMSNotifier
  def order_received(order_id)
    @order = Order.find(order_id)
    sms "#{@order.user.full_name}, cпасибо за ваш заказ №#{@order.id}. Мы свяжемся с вами в ближайшее время. :)", to: @order.address.phone
  end

  def order_received_admin(order_id)
    @admin_phones = User.admins.where(receive_sms: true).pluck(:phone)
    @order = Order.find(order_id)

    sms "New order ##{@order.id}! By #{@order.user.full_name}", to: @admin_phones
  end
end
