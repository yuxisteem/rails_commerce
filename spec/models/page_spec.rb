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

require 'spec_helper'

describe Page do
  pending "add some examples to (or delete) #{__FILE__}"
end
