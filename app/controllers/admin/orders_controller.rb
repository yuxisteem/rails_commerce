class Admin::OrdersController < Admin::AdminController
  add_breadcrumb I18n.t('admin.orders'), :admin_orders_path
  before_action :set_order, only: [:show, :edit, :update, :order_event, :shipment_event, :invoice_event, :destroy]

  # GET /admin/orders
  def index
    @orders = Order.all.includes(:invoice, :shipment, :order_items, :user).reverse_order.paginate(page: params[:page])
  end

  # GET /admin/orders/1
  def show
    add_breadcrumb "##{@order.id}"
  end

  # PATCH/PUT /admin/orders/1
  def update
    respond_to do |format|
      if Order.where(id: params[:id].split(',')).each { |x| x.update(order_params)}
        format.html { redirect_to admin_order_path(@order), notice: 'Order was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # POST /admin/orders/:id/shipment_event/:event
  def shipment_event
    fire_event @order.shipment, params[:event]
  end

  # POST /admin/orders/:id/invoice_event/:event
  def invoice_event
    fire_event @order.invoice, params[:event]
  end

  # POST /admin/orders/:id/order_event/:event
  def order_event
    fire_event @order, params[:event]
  end

  private

  def fire_event(object, event_name)
    event_name = event_name.to_sym
    if object.aasm.may_fire_event?(event_name)
      object.send(event_name)
      object.save
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
    params.require(:order).permit()
  end
end
