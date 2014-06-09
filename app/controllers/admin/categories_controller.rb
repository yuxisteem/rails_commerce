class Admin::CategoriesController < Admin::AdminController

  add_breadcrumb I18n.t('admin.categories'), :admin_categories_path

  before_action :set_category, except: [:index, :new, :create]

  def index
    @categories = Category.all.reverse_order.paginate(page: params[:page])
  end

  def show
    add_breadcrumb @category.name, admin_category_path(@category)
  end

  def new
    @category = Category.new
    add_breadcrumb t('admin.create')
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = t('admin.category_saved')
      redirect_to admin_category_path(@category)
    else
      render 'new'
    end
  end

  def update
    add_breadcrumb @category.name, admin_category_path(@category)
    add_breadcrumb t('admin.edit')
    if @category.update(category_params)
      redirect_to admin_category_path(@category)
      flash[:notice] = t('admin.category_updated')
    else
      render 'show'
    end
  end

  def destroy
    @category.destroy
    flash[:notice] = t('admin.category_deleted')
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category)
      .permit(:name, :description, :attribute_filter_enabled,
              :brand_filter_enabled)
  end

  def set_category
    @category = Category.find(params[:id])
  end

end
