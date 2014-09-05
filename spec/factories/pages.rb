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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    title "MyString"
    description "MyText"
    seo_title "MyString"
    seo_meta "MyText"
    visibility false
  end
end
