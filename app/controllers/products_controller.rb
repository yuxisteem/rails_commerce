class ProductsController < ApplicationController
  before_action :set_breadcrumb

  def show
    @product = Product.where(active: true).includes(:category).find(params[:id])
    add_breadcrumb @product.category.name, category_path(@product.category)
    add_breadcrumb @product.name
  end

  private
  def set_breadcrumb
    add_breadcrumb I18n.t('common.breadcrumb_home_name'), root_path
  end
end
