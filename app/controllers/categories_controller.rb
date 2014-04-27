class CategoriesController < ApplicationController
  before_action :set_breadcrumb

  def show
    @presenter = CategoryPresenter.new(category_id: params[:id], params: params)
    if params[:seo_name].nil?
      redirect_to category_seo_path(@presenter.category, @presenter.category.seo_name)
    elsif params[:seo_name] != @presenter.category.seo_name
      raise ActiveRecord::RecordNotFound
    end
    add_breadcrumb @presenter.category.name
  end

  private
  def set_breadcrumb
    add_breadcrumb I18n.t('common.breadcrumb_home_name'), root_path
  end
end
