class Admin::OrdersController < Admin::AdminController
  add_breadcrumb I18n.t('admin.orders'), :admin_orders_path
  before_action :set_order, only: [:show, :edit, :update, :order_event, :shipment_event, :invoice_event, :destroy]

  # GET /admin/orders
  # GET /admin/orders.json
  def index
    @orders = Order.all.includes(:invoice, :shipment, :order_items, :user).reverse_order.paginate(page: params[:page])
  end

  # GET /admin/orders/1
  # GET /admin/orders/1.json
  def show
    add_breadcrumb "##{@order.id}"
  end

  # PATCH/PUT /admin/orders/1
  # PATCH/PUT /admin/orders/1.json
  def update
    respond_to do |format|
      if Order.where(id: params[:id].split(',')).each { |x| x.update(order_params)}
        format.html { redirect_to admin_order_path(@order), notice: 'Order was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def shipment_event
    process_order_update_result @order.shipment.fire_state_event(params[:event])  
  end

  def invoice_event
    process_order_update_result @order.invoice.fire_state_event(params[:event])
  end

  def order_event
    process_order_update_result @order.fire_state_event(params[:event])
  end

  private

  def process_order_update_result(success)
    if success
      flash[:notice] = "Order update succesfully"
    else
      flash[:error] = "Error updating order"
    end
    redirect_to admin_order_path(@order)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.includes(:address, :shipment, :invoice, :order_histories).find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:archived, :paid, :fulfilled)
  end
end
