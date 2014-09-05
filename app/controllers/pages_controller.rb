class PagesController < ApplicationController
  def show
    Page.visible.find_by_seo_title!(params[:id])
  end
end
