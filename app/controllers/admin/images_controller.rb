class Admin::ImagesController < Admin::AdminController
  def index
    @images = Image.all
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new
    params[:Filedata].content_type = MIME::Types.type_for(params[:Filedata].original_filename)[0].to_s

    @image.image = params[:Filedata]

    @image.imageable_id = params[:imageable_id] unless params[:imageable_id].blank?
    @image.imageable_type = params[:imageable_type] unless params[:imageable_type].blank?

    respond_to do |format|
      if @image.save
        format.js { render :layout => false }
      end
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
  def image_params
    params.require(:image).permit(:image)
  end


end
