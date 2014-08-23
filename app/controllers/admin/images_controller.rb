class Admin::ImagesController < Admin::AdminController
  before_action :set_imageable, only: :create

  def index
    @images = Image.all
  end

  def new
    @image = Image.new
  end

  def create
    uploads = params[:files].map do |file|
      @imageable.images.build(image: file)
    end

    @imageable.save!

    render uploads
  end

  def show
    @image = Image.find(params[:id])
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.js { render layout: false }
    end
  end

  private

  def image_upload_params
    params.permit(:imageable_type, :imageable_id, :product_id, :files)
  end

  def imageable_id
    params[:imageable_id]
  end

  def set_imageable
    imageable_class = image_upload_params[:imageable_type].capitalize.constantize
    @imageable = imageable_class.find imageable_id
  end
end
