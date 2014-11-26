class Admin::OrdersController < Admin::AdminController
  add_breadcrumb I18n.t('admin.orders.orders'), :admin_orders_path
  before_action :set_order, except: :index

  # GET /admin/orders
  def index
    @orders = Order.all
                   .includes(:invoice, :shipment, :order_items, :user)
                   .reverse_order
                   .paginate(page: params[:page])

    @orders = @orders.where(aasm_state: selected_state) if selected_state
  end

  # GET /admin/orders/1
  def show
    add_breadcrumb "##{@order.id}"
  end

  # PATCH/PUT /admin/orders/1
  def update
    @order.update(order_params, updated_by: current_user)
    @order.order_events.reload
    respond_to do |format|
      format.html { head :ok }
      format.js { render 'panel_with_activity' }
    end
  end


  private

  def selected_state
    state_params = params[:state]
    session[:orders_selected_state] = state_params if state_params
    session.delete(:orders_selected_state) if state_params == 'all'
    @selected_state = session[:orders_selected_state]
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.includes(:address, :shipment, :invoice, :order_events).find(params[:id]).decorate
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:note, :aasm_state, invoice_attributes: [:aasm_state], shipment_attributes: [:aasm_state])
  end
end
