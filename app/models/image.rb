# == Schema Information
#
# Table name: images
#
#  id                 :integer          not null, primary key
#  created_at         :datetime
#  updated_at         :datetime
#  imageable_id       :integer
#  imageable_type     :string(255)
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Image < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  has_attached_file :image, styles: { big: 'x1024>',
                                      medium: 'x300>',
                                      thumb: 'x150>' },
                            default_url: '/images/:style/missing.png'

  validates_attachment :image, presence: true,
                               size: { in: 0..10.megabytes }
  validates_attachment_content_type :image, content_type: /image/
end
