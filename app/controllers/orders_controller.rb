class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart

  def new
    if @cart.empty?
      flash[:notice] = t('store.cart_empty_message')
      redirect_to root_path
    end

    @order_presenter = OrderPresenter.new

    if user_signed_in?
      @order_presenter.update(address: current_user.address,
                              first_name: current_user.first_name,
                              last_name: current_user.last_name,
                              email: current_user.email,
                              phone: current_user.phone)
    end
  end

  def create
    if @cart.empty?
      flash[:notice] = t('store.cart_empty_message')
      redirect_to root_path
    else
      @order_presenter = OrderPresenter.new(order_info_params)

      if @order_presenter.valid?
        user = find_or_create_user(order_info_params)
        @order = @order_presenter.build_order(@cart, user)

        if @order.save!
          @cart.destroy
          flash[:success] = t('checkout.order_successful_submit')
        end
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
  def order_info_params
    params.require(:order_presenter).permit(:first_name, :last_name, :email,
                                            :phone, :street, :city, :note)
  end

  def find_or_create_user(params)
    User.find_by_email(params[:email]) || User.find_by_email(params[:phone]) || create_user(params)
  end

  def create_user(params)
    User.create_from_checkout(params)
  end


end
