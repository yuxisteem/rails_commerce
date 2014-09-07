module ApplicationHelper

  def nav_link_to(body, url, options = {})
    if current_page?(url) || options[:inclusive] && request.path.include?(url)
      if options[:class]
        options[:class] = options[:class] + ' active'
      else
        options[:class] = 'active'
      end
    end
    options.delete(:inclusive) if options && options.key?(:inclusive)
    link_to(body, url, options)
  end

  def full_title(page_title)
    base_title = I18n.t('common.store_name')
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def label_span(text, type: 'default')
    "<span class=\"label label-#{type}\">#{text}</span>".html_safe
  end

  def badge_span(text, id: nil)
    if id
      "<span id=#{id} class=\"badge\">#{text}</span>".html_safe
    else
      "<span class=\"badge\">#{text}</span>".html_safe
    end
  end

  def glyphicon(name, text: nil, before_text: nil)
    "#{before_text} <span class=\"glyphicon #{name}\"></span> #{text}".html_safe
  end
end
