class StoreController < ApplicationController
  before_action :set_breadcrumb

  def index
    @products = Product.where(active: true).includes(:images).paginate(page: params[:page])
  end

  def search
    @products = Product.find_all_by_term(params[:q]).paginate(page: params[:page])
    add_breadcrumb I18n.t('store.search')
  end

  private
  def set_breadcrumb
  	add_breadcrumb I18n.t('common.breadcrumb_home_name'), root_path
  end
end
