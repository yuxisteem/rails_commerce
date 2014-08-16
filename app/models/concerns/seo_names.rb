module SeoNames
  extend ActiveSupport::Concern

  def seo_name
    Transliteration::transliterate(name).parameterize
  end
end
