class Admin::CategoriesController < Admin::AdminController
  add_breadcrumb I18n.t('admin.categories.categories'), :admin_categories_path

  before_action :set_category, only: [:show, :destroy, :update]
  def index
    @categories = Category.all.paginate(page: params[:page])
  end

  def show
    add_breadcrumb @category.name, admin_category_path(@category)
  end

  def new
    @category = Category.new
    add_breadcrumb t('admin.common.create')
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = t('admin.categories.category_saved')
      redirect_to admin_category_path(@category)
    else
      render 'new'
    end
  end

  def update
    add_breadcrumb @category.name, admin_category_path(@category)
    add_breadcrumb t('admin.common.edit')
    if @category.update(category_params)
      redirect_to admin_category_path(@category)
      flash[:notice] = t('admin.categories.category_updated')
    else
      render 'show'
    end
  end

  def order
    Category.reorder! params[:ids]
    render nothing: true
  end

  def destroy
    @category.destroy
    flash[:notice] = t('admin.categories.category_deleted')
    redirect_to admin.categories.categories_path
  end

  private

  def category_params
    params.require(:category)
      .permit(:name, :description, :active, :attribute_filter_enabled,
              :brand_filter_enabled)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
