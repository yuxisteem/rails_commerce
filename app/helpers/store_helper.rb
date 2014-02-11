module StoreHelper
  def available_categories
    @available_categories ||= Category.all
  end

  def filter_link_for(q = nil, options = nil, html_options = nil) 

  	q ||= {}

  	attribute_id = options[:id].to_s
  	attribute_value = options[:value]
  	attribute_params = q[attribute_id].try(:dup) || []

  	category_id = options[:category_id]

  	active = attribute_params.include?(attribute_value) unless attribute_params.nil?

  	if active
  		attribute_params.delete(attribute_value)
  	else
  		attribute_params ||= []
  		attribute_params << attribute_value
  	end


  	link_text = options[:value]
  	link_text += "<span class=\"badge pull-right\">#{options[:count].to_s}</span>" if options[:count]

  	link_params = q.dup

    #puts attribute_params.inspect

  	if attribute_params.any?
  		link_params[attribute_id] = attribute_params
  	else
  		link_params.delete(attribute_id)
  		link_params = nil unless link_params.any?
  	end
  	


  	link_path = store_browse_path(id: category_id, q: link_params)
  	link_to link_text.html_safe, link_path
  end

  def filter_active?(q, options ={})
  	q ||= {}
  	attribute_id = options[:id].to_s
  	attribute_value = options[:value]
  	if attribute_id && q[attribute_id]
  		q[attribute_id].include?(attribute_value)
  	end
  end

  def search_query
  	params[:search] if current_page?(store_search_path)
  end
end
