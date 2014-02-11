class Admin::CategoriesController < Admin::AdminController

  add_breadcrumb I18n.t('admin.categories'), :admin_categories_path

  def index
    @categories = Category.all.reverse_order.paginate(page: params[:page])
  end

  def show
    @category = Category.find(params[:id])
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
    @category = Category.find(params[:id])
    add_breadcrumb @category.name, admin_category_path(@category)
    add_breadcrumb t('admin.edit')
    if @category.update(category_params)
      redirect_to admin_category_path(@category)
      flash[:notice] = t('admin.category_updated')
    else
      render 'edit'
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:notice] = t('admin.category_deleted')
    redirect_to admin_categories_path
  end  

  private
  def category_params
    params.require(:category).permit(:name, :description)
  end

end
