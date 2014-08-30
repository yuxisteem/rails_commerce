class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart

  def new
    if @cart.empty?
      flash[:notice] = t('store.cart_empty_message')
      redirect_to root_path
    end

    @order = Order.new(order_items: @cart.to_order_items,
                       user: current_user || User.new,
                       address: current_user.try(:address) || Address.new)
  end

  def create
    if @cart.empty?
      flash[:notice] = t('store.cart_empty_message')
      redirect_to root_path
    else
      @order = Order.new(order_params.merge(order_items: @cart.to_order_items))
      @order.user = init_user
      if @order.valid?
        Order.transaction do
          @order.save!
          @cart.destroy
        end
        flash[:success] = t('checkout.order_successful_submit')
        redirect_to order_path(id: @order.code)
      else
        render 'new'
      end
    end
  end

  def show
    @order = Order.find_by_code!(params[:id])
  end

  private

  def order_params
    params.require(:order)
          .permit(user_attributes: [:first_name, :last_name, :email],
                  address_attributes: [:phone, :street, :city], note: {})
  end

  def user_params
    order_params[:user_attributes]
  end

  def address_params
    order_params[:address_attributes]
  end

  # Find user by email create new if no user found
  def init_user
    User.find_by_email(user_params[:email]) ||
      User.generate(user_params)
  end
end
