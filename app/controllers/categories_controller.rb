class CategoriesController < ApplicationController
  before_action :set_breadcrumb

  def show
    @category = CategoryPresenter.new(Category.find(params[:id]), params: params)

    if params[:seo_name].nil?
      redirect_to seo_category_path(@category, @category.seo_name)
    elsif params[:seo_name] != @category.seo_name
      fail ActiveRecord::RecordNotFound
    end
    add_breadcrumb @category.name
  end

  private

  def set_breadcrumb
    add_breadcrumb I18n.t('common.breadcrumb_home_name'), root_path
  end
end
