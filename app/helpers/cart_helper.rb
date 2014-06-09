module CartHelper
  def current_cart
    @cart ||= Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
    return @cart
  end

  def cart_widget_visible?
    !(params[:controller] == 'orders' && (params[:action] == 'new' || params[:action] == 'create'))
  end
end
