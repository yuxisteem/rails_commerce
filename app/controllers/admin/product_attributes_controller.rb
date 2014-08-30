class Admin::ProductAttributesController < Admin::AdminController
  def create
    @product_attribute = ProductAttribute.new(product_attributes_params)
    if @product_attribute.save
      flash[:notice] = I18n.t('admin.product_attributes.product_attribute_saved')
    end
    redirect_to admin_category_path(id: params[:category_id])
  end

  def update
    @product_attribute = ProductAttribute.find(params[:id]).update!(product_attributes_params)
    if @product_attribute.save
      flash[:notice] = I18n.t('admin.product_attributes.product_attribute_updated')
    end
    redirect_to admin_category_path(id: params[:category_id])
  end

  def destroy
    if ProductAttribute.delete(params[:id])
      flash[:notice] = I18n.t('admin.product_attributes.product_attribute_deleted')
    end
    redirect_to admin_category_path(id: params[:category_id])
  end

  private
  def product_attributes_params
    params.require(:product_attribute).permit(:name, :filterable).merge({category_id: params[:category_id]})
  end
end
