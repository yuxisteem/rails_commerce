class StoreController < ApplicationController 
  before_action :set_breadcrumb

  def index
    @products = Product.where(active: true).includes(:images).paginate(page: params[:page])
  end

  def browse
    @presenter = StoreBrowsePresenter.new(category_id: params[:id], params: params)
  	add_breadcrumb @presenter.category.name
  end

  def show
  	@product = Product.where(active: true).includes(:category).find(params[:id])
  	add_breadcrumb @product.category.name, store_browse_path(id: @product.category.id)
  	add_breadcrumb @product.name
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
