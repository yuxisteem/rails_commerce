class ProductsController < ApplicationController
  before_action :set_breadcrumb

  def show
    @product = Product.active.includes(:category).find(params[:id])

    if params[:seo_name].nil?
      redirect_to seo_category_path(@product, @product.seo_name)
    elsif params[:seo_name] != @product.seo_name
      fail ActiveRecord::RecordNotFound
    end

    add_breadcrumb @product.category.name, seo_category_path(@product.category, @product.category.seo_name)
    add_breadcrumb @product.name
  end

  private

  def set_breadcrumb
    add_breadcrumb I18n.t('common.breadcrumb_home_name'), root_path
  end
end
