class Admin::UsersController < Admin::AdminController

  add_breadcrumb I18n.t('admin.users.users'), :admin_users_path

  def index
    @users = User.all.reverse_order.includes(orders: [:order_items])
                 .paginate(page: params[:page])
  end

  def show
    @user = User.includes(:orders).find(params[:id])
    add_breadcrumb "##{@user.id}"
  end

  def update
    @user = User.find(params[:id]).update(user_params)
    head :ok
  end

  def destroy
    redirect_to admin_users_path if User.find(params[:id]).delete
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :admin, :phone)
  end
end
