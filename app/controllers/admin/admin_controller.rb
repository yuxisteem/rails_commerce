class Admin::AdminController < ApplicationController
  before_action :require_admin

  layout 'admin/admin_layout'

  add_breadcrumb I18n.t('admin.common.admin_panel'), :admin_path

  protected
  def require_admin
    redirect_to root_path unless current_user && current_user.admin?
  end
end