class Admin::BrandsController < Admin::AdminController
  add_breadcrumb I18n.t('admin.brands'), :admin_brands_path
  def index
    @brands = Brand.all.reverse_order.paginate(page: params[:page])
  end

  def show
    @brand = Brand.find(params[:id])
    add_breadcrumb @brand.name, admin_brand_path(@brand)
  end

  def new
    @brand = Brand.new
    add_breadcrumb t('admin.create')
  end

  def create
    @brand = Brand.new(brand_params)
    if @brand.save
      flash[:notice] = t('admin.brand_saved')
      redirect_to admin_brand_path(@brand)
    else
      render 'new'
    end
  end

  def edit
    @brand = Brand.find(params[:id])
    add_breadcrumb @brand.name, admin_brand_path(@brand)
    add_breadcrumb t('admin.edit')
  end

  def update
    @brand = Brand.find(params[:id])
    add_breadcrumb @brand.name, admin_brand_path(@brand)
    add_breadcrumb t('admin.edit')
    if @brand.update(brand_params)
      redirect_to admin_brand_path(@brand)
      flash[:notice] = t('admin.brand_updated')
    else
      render 'edit'
    end
  end

  def destroy
    Brand.find(params[:id]).destroy
    flash[:notice] = t('admin.brand_deleted')
    redirect_to admin_brands_path
  end

  private
  def brand_params
    params.require(:brand).permit(:name, :description)
  end
end
