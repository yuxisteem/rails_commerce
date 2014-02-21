module StoreHelper
  def available_categories
    @available_categories ||= Category.all
  end

  def attribute_filter_link(options = {}, html_options = nil)

    filter_query = params[:q] || {}

    attribute_id = options[:key].to_s
    attribute_value = options[:value]
    attribute_params = filter_query[attribute_id].try(:dup) || []

    category_id = options[:category_id]

    if attribute_filter_active?(key: attribute_id, value: attribute_value)
      attribute_params.delete(attribute_value)
    else
      attribute_params ||= []
      attribute_params << attribute_value
    end


    link_text = options[:value]
    link_text += "<span class=\"badge pull-right\">#{options[:count].to_s}</span>" if options[:count]

    link_to link_text.html_safe, store_browse_path(id: category_id, q: attributes_link_params(attribute_params, attribute_id))
  end

  def attribute_filter_active?(options ={})
    filter_query = params[:q] || {}

    attribute_id = options[:key].to_s
    attribute_value = options[:value]
    if attribute_id && filter_query[attribute_id]
      filter_query[attribute_id].include?(attribute_value)
    end
  end

  def search_query
    params[:search] if current_page?(store_search_path)
  end

  def brand_filter_link(brand, options = {})
    brands_ids = []
    selected_brand_id = brand.id

    if params[:brands]
      brands_ids = params[:brands].dup
    end

    link_params = params.dup

    if brands_ids.include?(selected_brand_id.to_s)
      brands_ids.delete(selected_brand_id.to_s)
    else
      brands_ids << selected_brand_id.to_s
    end

    link_params[:brands] = brands_ids

    link_text = brand.name
    link_text += "<span class=\"badge pull-right\">#{options[:count].to_s}</span>" if options[:count]

    link_to link_text, store_browse_path(link_params)
  end

  def brand_filter_active?(brand)
    if params[:brands]    
      params[:brands].include?(brand.id.to_s)
    end
  end

  private

  def attributes_link_params(attribute_params, attribute_id)
    filter_query = params[:q].try(:dup) || {}

    if attribute_params.any?
      filter_query[attribute_id] = attribute_params
    else
      filter_query.delete(attribute_id)
      filter_query = nil unless params.any?
    end
    filter_query
  end
end
