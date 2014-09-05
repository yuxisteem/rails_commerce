module CurrentCart
  extend ActiveSupport::Concern

  private

  def active_pages
    @visible_pages ||= Page.visible
  end
end
