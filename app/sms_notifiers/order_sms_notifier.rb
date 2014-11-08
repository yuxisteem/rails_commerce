class OrderSMSNotifier < SMSNotifier
  def order_received(order_id)
    @order = Order.find(order_id)
    sms I18n.t('sms_notifiers.order.order_placed_admin', name: @order.user.full_name, order_id: @order.id), to: @order.address.phone
  end

  def order_placed_admin(order_id)
    @admin_phones = User.admins.where(receive_sms: true).pluck(:phone)
    @order = Order.find(order_id)

    sms I18n.t('sms_notifiers.order.order_placed_admin', name: @order.user.full_name, order_id: @order.id), to: @admin_phones
  end
end
