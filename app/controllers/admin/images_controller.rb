class Admin::ImagesController < Admin::AdminController
  before_action :set_imageable_klass, only: :create

  def index
    @images = Image.all
  end

  def new
    @image = Image.new
  end

  def create
    image_upload_params[:files].each do |file|

    end
  end

  def show
    @image = Image.find(params[:id])
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  private
  def image_upload_params
    params.permit(:files, :imageable_type, :imageable_id)
  end

  def set_imageable_klass
    @imageable_klass = image_upload_params[:imageable_type].capitalize.constantize
  end

end