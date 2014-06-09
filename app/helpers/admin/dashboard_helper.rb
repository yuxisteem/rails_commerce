module Admin::DashboardHelper
  def unfulfilled_orders_count
    unfulfilled_orders_counter = Order.where(aasm_state: 'in_progress').count
  end
end
