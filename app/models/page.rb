# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  text       :text
#  seo_title  :string(255)
#  seo_meta   :text
#  visible    :boolean
#  created_at :datetime
#  updated_at :datetime
#

class Page < ActiveRecord::Base
  validates :title, presence: true
  validates :text, presence: true
  validates :seo_title, presence: true

  scope :visible, -> { where(visible: true) }
end
