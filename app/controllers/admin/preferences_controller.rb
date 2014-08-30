class Admin::PreferencesController < Admin::AdminController
  add_breadcrumb I18n.t('admin.preferences.page_title'), :admin_preferences_path

  def index
    @user = current_user
  end

  def update
    @user = current_user
    if @current_user.update(user_settings_params)
      flash[:notice] = t('admin.preferences.updated')
      redirect_to admin_preferences_path
    else
      render 'index'
    end
  end

  def user_settings_params
    params.require(:user).permit(:first_name, :last_name, :phone, :email, :receive_sms, :receive_email)
  end
end
