class Admin::PagesController < Admin::AdminController
  before_action :set_page, except: [:index, :new, :create]

  add_breadcrumb I18n.t('admin.pages.pages'), :admin_pages_path

  def index
    @pages = Page.all.paginate(page: params[:page])
  end

  def show
    add_breadcrumb @page.name
  end

  def new
    @page = Page.new
    add_breadcrumb t('admin.common.new')
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
    add_breadcrumb @page.name, admin_page_path(@page)
    add_breadcrumb 'Edit'

    if @page.update(page_params)
      flash[:notice] = t('admin.pages.page_updated')
      redirect_to admin_page_path(@page)
    else
      render 'show'
    end
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
          .permit(:title, :text, :seo_title, :seo_meta, :visibility)
  end

  def set_page
    @page = Page.find(params[:id])
  end
end
