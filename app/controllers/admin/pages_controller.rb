class Admin::PagesController < Admin::AdminController
  before_action :set_page, only: [:show, :destroy, :update]

  add_breadcrumb I18n.t('admin.pages.pages'), :admin_pages_path

  def index
    @pages = Page.all.paginate(page: params[:page])
  end

  def show
    add_breadcrumb @page.title
  end

  def new
    @page = Page.new
    add_breadcrumb t('admin.common.create')
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      flash[:notice] = t('admin.pages.page_saved')
      redirect_to admin_page_path(@page)
    else
      add_breadcrumb t('admin.common.create')
      render 'new'
    end
  end

  def update
    add_breadcrumb @page.title, admin_page_path(@page)
    add_breadcrumb 'Edit'

    if @page.update(page_params)
      flash[:notice] = t('admin.pages.page_updated')
      redirect_to admin_page_path(@page)
    else
      render 'show'
    end
  end

  def order
    Page.reorder! params[:ids]
    render nothing: true
  end

  def destroy
    if @page.destroy!
      flash[:notice] = t('admin.pages.page_deleted')
      redirect_to admin_pages_path
    else
      flash[:error] = t('admin.pages.page_delete_error')
      redirect_to admin_page_path(@page)
    end
  end

  private

  def page_params
    params.require(:page)
          .permit(:title, :text, :seo_url, :visible)
  end

  def set_page
    @page = Page.find(params[:id])
  end
end
