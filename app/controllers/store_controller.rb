class StoreController < ApplicationController
  
  before_action :set_breadcrumb

  def index
    @products = Product.where(active: true).paginate(page: params[:page])
  end

  def browse
  	# @products = Product.where(active: true, category_id: params[:id]).paginate(page: params[:page])
  	# @category = Category.find(params[:id])
    @presenter = StoreBrowsePresenter.new(category_id: params[:id], page: params[:page], q: params[:q])
  	add_breadcrumb @presenter.category.name
  end

  def show
  	@product = Product.where(active: true).includes(:category).find(params[:id])
  	add_breadcrumb @product.category.name, store_browse_path(id: @product.category.id)
  	add_breadcrumb @product.name
  end

  def search
    @products = Product.find_all_by_term(params[:search]).paginate(page: params[:page])
    add_breadcrumb I18n.t('store.search')
  end

  private
  def set_breadcrumb
  	add_breadcrumb I18n.t('common.breadcrumb_home_name'), root_path
  end
end
