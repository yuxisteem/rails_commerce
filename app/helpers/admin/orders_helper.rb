module Admin::OrdersHelper
  def event_link(order, event_name, type: 'order')
    path = event_admin_order_path(order, name: event_name, type: type)
    opts = { remote: true, method: :post, class: 'btn btn-default' }

    link_to t("admin.orders.events.#{type}.#{event_name}"), path, opts
  end

  def order_event_link(order, name)
    event_link order, name if order.send("may_#{name}?")
  end

  def shipment_event_link(order, name)
    event_link order, name, type: 'shipment' if order.shipment.send("may_#{name}?")
  end

  def invoice_event_link(order, name)
    event_link order, name, type: 'invoice' if order.invoice.send("may_#{name}?")
  end
end
