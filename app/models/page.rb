# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  text       :text
#  seo_url    :string(255)
#  visible    :boolean
#  created_at :datetime
#  updated_at :datetime
#  weight     :integer
#

class Page < ActiveRecord::Base
  include Orderable
  validates :title, presence: true
  validates :text, presence: true
  validates :seo_url, presence: true, uniqueness: true

  scope :visible, -> { where(visible: true) }
end
