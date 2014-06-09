class StoreController < ApplicationController
  before_action :set_breadcrumb

  ITEMS_PER_PAGE = 15

  def index
    @products = Product.where(active: true).includes(:images).paginate(page: params[:page], per_page: ITEMS_PER_PAGE)
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
