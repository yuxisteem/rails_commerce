module SeoNames
  extend ActiveSupport::Concern

  def to_param
    [id, seo_name.parameterize].join("-")
  end

  def seo_name
    Transliteration::transliterate(name).parameterize
  end
end
