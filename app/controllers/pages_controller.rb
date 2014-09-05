class StaticPagesController < ApplicationController
  def show
    Page.visible.find_by_seo_name!(params[:id])
  end
end
