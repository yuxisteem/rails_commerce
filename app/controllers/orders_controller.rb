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

    respond_to do |format|
      format.html {}
    end
  end

  def create
    if @cart.empty?
      flash[:notice] = t('store.cart_empty_message')
      redirect_to root_path
    else
      @order_presenter = OrderPresenter.new(order_info_params)

      if @order_presenter.valid?

        existing_customer = find_existing_customer(order_info_params)
        user = find_existing_customer(order_info_params) || create_user(order_info_params)

        @order = Order.build_from_cart(@cart)
        @order.update(address: @order_presenter.address,
                      note: @order_presenter.note,
                      user: user)

        if @order.save!
          if existing_customer
            user.update_from_order_info(@order_presenter)
          else
            UserNotifier.account_created(user.id, user.password).deliver
          end

          OrderNotifier.order_received(@order.id).deliver
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
    params.require(:order_presenter).permit(:first_name, :last_name, :email, :phone, :street, :city, :note)
  end

  def find_existing_customer(params)
    user_by_email = User.find_by_email(params[:email])
    user_by_phone = User.find_by_email(params[:phone])

    if not user_by_email.blank?
      user_by_email
    elsif not user_by_phone.blank?
      user_by_phone
    end
  end

  def create_user(params)
    password = Devise.friendly_token.first(8)
    User.create(first_name: params[:first_name],
                last_name: params[:last_name],
                email: params[:email],
                phone: params[:phone],
                password: password,
                password_confirmation: password)
  end


end
