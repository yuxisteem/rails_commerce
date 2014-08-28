class OrderSMSNotifier < SMSNotifier
  def order_recieved(order_id)
    @order = Order.find(order_id)
    sms "#{@order.user.full_name}, cпасибо за ваш заказ №#{@order.id}. Мы свяжемся с вами в ближайшее время.", to: @order.user.phone
  end

  def order_recieved_admin(order_id)
    @admin_phones = User.where(admin: true).pluck(:phone)
    @order = Order.find(order_id)

    sms "New order ##{@order.id}! #{admin_order_url(@order)} By #{@order.user.full_name}", to: @admin_phones
  end
end
