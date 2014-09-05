module PagesHelper
  def visible_pages
    @visible_pages ||= Page.visible
  end
end
