class Admin::DashboardController < Admin::AdminController
  def index
    @updates = OrderHistory.all.reverse_order.limit(10)
    @orders = Order.all.reverse_order.limit(10)
  end
end
