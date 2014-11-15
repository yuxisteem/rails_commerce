class Admin::OrderEventsController < Admin::AdminController
  before_action :set_admin_order_event, only: [:show, :edit, :update, :destroy]

  # POST /admin/order_events
  # POST /admin/order_events.json
  def create
    @order = Order.find(params[:order_id]).decorate
    @order.order_events << OrderEvent.new(admin_order_event_params)

    respond_to do |format|
        format.js { render 'admin/orders/panel_with_activity' }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_order_event_params
      params.require(:order_event).permit(:note).merge(user: current_user, event_type: 'Note')
    end
end
