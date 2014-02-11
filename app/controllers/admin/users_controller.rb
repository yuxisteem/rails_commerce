class Admin::UsersController < Admin::AdminController

  add_breadcrumb I18n.t('admin.users'), :admin_users_path

  def index
    @users = User.all.reverse_order.includes(:orders).paginate(page: params[:page])
  end

  def show    
    @user = User.includes(:orders).find(params[:id])
    add_breadcrumb "##{@user.id}"
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = t('admin.user_updated')
      redirect_to admin_user_path(@user)
    end
  end

  def destroy
    if User.find(params[:id]).delete
      redirect_to admin_users_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :admin, :phone)
  end
end
