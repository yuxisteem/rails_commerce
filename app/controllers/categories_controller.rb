class CategoriesController < ApplicationController
  before_action :set_breadcrumb

  def show
    @category = CategoryPresenter.new(Category.find(params[:id]), params: params)

    @category.category.ancestors.each { |category| add_breadcrumb category.name, category_path(category) }

    add_breadcrumb @category.name
  end

  private

  def set_breadcrumb
    add_breadcrumb I18n.t('common.breadcrumb_home_name'), root_path
  end
end
