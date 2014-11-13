class Admin::ProductAttributeNamesController < Admin::AdminController

  before_action :set_attribute, only: [:destroy, :update]

  def create
    @attribute = ProductAttributeName.new(product_attributes_params)
    if @attribute.save
      flash[:notice] = I18n.t('admin.product_attribute_names.product_attribute_saved')
    end

    respond_to do |format|
      format.html { redirect_to admin_category_path(id: params[:category_id]) }
      format.js {}
    end
  end

  def update
    @attribute.update(product_attributes_params)
    if @attribute.save
      flash[:notice] = I18n.t('admin.product_attribute_names.product_attribute_updated')
    end

    respond_to do |format|
      format.html { redirect_to admin_category_path(id: params[:category_id]) }
      format.js {}
    end
  end

  def destroy
    if @attribute.delete
      flash[:notice] = I18n.t('admin.product_attribute_names.product_attribute_deleted')
    end

    respond_to do |format|
      format.html { redirect_to admin_category_path(id: params[:category_id]) }
      format.js {}
    end
  end

  def order
    ProductAttributeName.reorder! params[:ids]
    render nothing: true
  end

  def autocomplete
    values = ProductAttributeValue
              .where('value ILIKE ? AND product_attribute_name_id = ?', "%#{params[:q]}%", params[:id])
              .distinct
              .pluck(:value)
              .map { |x| { value: x } }
    p values
    render json: values
  end

  private

  def product_attributes_params
    params.require(:product_attribute_name).permit(:name, :filterable).merge({category_id: params[:category_id]})
  end

  def set_attribute
    @attribute = ProductAttributeName.find(params[:id])
  end
end
