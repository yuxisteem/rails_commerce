class Admin::ProductsController < Admin::AdminController

  before_action :set_product, except: [:index, :new, :create]

  add_breadcrumb I18n.t('admin.products'), :admin_products_path

  def index
    @q = Product.search(params[:q])
    @products = @q.result.includes(:category, :brand).reverse_order.paginate(page: params[:page])
  end

  def show
    @categories = Category.all
    @brands = Brand.all
    add_breadcrumb @product.name
  end

  def new
    @product = Product.new
    @categories = Category.all
    @brands = Brand.all
    add_breadcrumb I18n.t('admin.create')
  end

  def create
    @product = Product.create(product_params)
    if @product.save
      flash[:notice] = t('admin.product_saved')
      redirect_to admin_product_path(@product)
    else
      @categories = Category.all
      @brands = Brand.all
      add_breadcrumb I18n.t('admin.create')
      render 'new'
    end
  end

  def update
    add_breadcrumb @product.name, admin_product_path(@product)
    add_breadcrumb 'Edit'
    if @product.update(product_params)
      flash[:notice] = t('admin.product_updated')
      redirect_to admin_product_path(@product)
    else
      @categories = Category.all
      @brands = Brand.all
      render 'show'
    end
  end

  def destroy
    if @product.destroy!
      flash[:notice] = t('admin.product_deleted')
      redirect_to admin_products_path
    end
  end

  def clone
    @product = @product.clone
    if @product.save!
      flash[:notice] = t('admin.product_cloned')
      redirect_to admin_product_path(@product)
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id, :active, :brand_id, product_attribute_values_attributes: [:id, [:value, :product_attribute_id]])
  end

  def set_product
    @product = Product.find(params[:id])
  end

end
