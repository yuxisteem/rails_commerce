class Admin::DashboardController < Admin::AdminController
  def index
    @updates = OrderHistory.all.reverse_order.limit(10)
    @orders = Order.all.includes(:invoice, :shipment, :order_items).reverse_order.limit(10)
  end
end
