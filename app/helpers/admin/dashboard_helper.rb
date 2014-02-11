module Admin::DashboardHelper
	def unfulfilled_orders_count
		@unfulfilled_orders_counter = Order.where(state: 0).count
	end
end
