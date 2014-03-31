module StoreHelper

  ATTRIBUTES_FILTER_KEY = :q
  BRANDS_FILTER_KEY = :brands


  def available_categories
    @available_categories ||= Category.all
  end

  def attribute_filter_link(attribute_value, options = {})

    attribute_value_text = attribute_value.value

    link_text = attribute_value_text
    link_text += "<span class=\"badge pull-right\">#{options[:count].to_s}</span>" if options[:count]

    link_to link_text.html_safe, store_browse_path(attributes_link_params(attribute_value)), options
  end

  def attribute_filter_active?(attribute_value)
    filter_query = params[ATTRIBUTES_FILTER_KEY] || {}
    attribute_id = attribute_value.product_attribute.id.to_s

    if attribute_id && filter_query[attribute_id]
      filter_query[attribute_id].include?(attribute_value.value)
    end
  end

  def search_query
    params[:q] if current_page?(store_search_path)
  end

  def brand_filter_link(brand, options = {})
    brands_ids = []
    selected_brand_id = brand.id

    if params[BRANDS_FILTER_KEY]
      brands_ids = params[BRANDS_FILTER_KEY].dup
    end

    link_params = params.dup

    if brands_ids.include?(selected_brand_id.to_s)
      brands_ids.delete(selected_brand_id.to_s)
    else
      brands_ids << selected_brand_id.to_s
    end

    link_params[BRANDS_FILTER_KEY] = brands_ids

    link_text = brand.name
    link_text += "<span class=\"badge pull-right\">#{options[:count].to_s}</span>" if options[:count]

    link_to link_text.html_safe, store_browse_path(link_params), options
  end

  def brand_filter_active?(brand)
    if params[BRANDS_FILTER_KEY]
      params[BRANDS_FILTER_KEY].include?(brand.id.to_s)
    end
  end

  private

  def attributes_link_params(attribute_value)
    link_params = params.dup

    attribute_params = []

    attribute_id = attribute_value.product_attribute.id.to_s

    if link_params[ATTRIBUTES_FILTER_KEY] && link_params[ATTRIBUTES_FILTER_KEY][attribute_id]
      attribute_params = link_params[ATTRIBUTES_FILTER_KEY][attribute_id].dup
    end

    if attribute_filter_active?(attribute_value)
      attribute_params.delete(attribute_value.value)
    else
      attribute_params  << attribute_value.value
    end

    if link_params[ATTRIBUTES_FILTER_KEY]
      link_params[ATTRIBUTES_FILTER_KEY] = link_params[ATTRIBUTES_FILTER_KEY].merge({attribute_id => attribute_params})
    else
      link_params[ATTRIBUTES_FILTER_KEY] = {attribute_id => attribute_params}
    end

    link_params
  end
end
