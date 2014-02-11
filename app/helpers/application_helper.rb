module ApplicationHelper

  include UploadifyRailsHelper

  def full_title(page_title)
    base_title = I18n.t('common.store_name')
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def label_span(text, params = {})
  	type = params[:type] || 'default'
      "<span class=\"label label-#{type}\">#{text}</span>".html_safe
  end

  def badge_span(text)
      "<span class=\"badge\">#{text}</span>".html_safe
  end

end