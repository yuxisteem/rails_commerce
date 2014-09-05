# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  text       :text
#  seo_title  :string(255)
#  seo_meta   :text
#  visibility :boolean
#  created_at :datetime
#  updated_at :datetime
#

class Page < ActiveRecord::Base
  include SeoNames

  scope :visible, -> { where(visibility: true) }
end
