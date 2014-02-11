class CartItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart

  def index
    respond_to do |format|
      format.js {}
    end
  end

  def create
    product = Product.find(params[:product_id])
    cart_item = CartItem.new(product_id: product.id)

    unless @cart.cart_items.where(product_id: product.id).any?
      @cart.cart_items.append(cart_item)
    end

    respond_to do |format|
      format.js {}
    end
  end

  def update

  end

  def destroy
    if params[:id].blank?
      @cart.cart_items.clear
    else
      @cart.cart_items.find(params[:id]).destroy
    end
    respond_to do |format|
      format.js {}
    end
  end

  def increase
    cart_item = @cart.cart_items.find(params[:id])
    cart_item.update(quantity: cart_item.quantity + 1)
    respond_to do |format|
      format.js { render 'cart_items/update' }
    end
  end

  def decrease
    cart_item = @cart.cart_items.find(params[:id])
    if cart_item.quantity > 1
      cart_item.update(quantity: cart_item.quantity - 1)
      respond_to do |format|
        format.js { render 'cart_items/update' }
      end
    else
      cart_item.destroy
      respond_to do |format|
        format.js { render 'cart_items/destroy' }
      end
    end
  end

end
