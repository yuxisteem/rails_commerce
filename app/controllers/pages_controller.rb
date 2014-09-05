class PagesController < ApplicationController
  def show
    @page = Page.visible.find_by_seo_url!(params[:id])
  end
end
