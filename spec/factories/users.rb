# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  phone                  :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  admin                  :boolean
#  receive_sms            :boolean          default(TRUE)
#  receive_email          :boolean          default(TRUE)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :user do
    email Faker::Internet::email
    password "12345"
    password_confirmation "12345"
    first_name "John"
    last_name  "Doe"
    phone Faker::PhoneNumber.phone_number
    admin false
  end

  factory :admin, class: User do
    email "admin@example.com"
    password '12345'
    password_confirmation '12345'
    first_name "Admin"
    last_name  "User"
    phone      Faker::PhoneNumber.phone_number
    admin      true
  end
end
