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

class User < ActiveRecord::Base
  has_many :orders
  has_many :order_events

  has_one :address, through: :orders
  has_many :addresses, through: :orders

  scope :admins, -> { where(admin: true) }

  after_create :notify_created

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def full_name
    "#{first_name} #{last_name}"
  end

  def address
    Order.where(user_id: id).last.try(:address)
  end

  def self.generate(options)
    password = Devise.friendly_token.first(8)
    User.new(
      first_name: options[:first_name],
      last_name: options[:last_name],
      email: options[:email],
      phone: options[:phone],
      password: password,
      password_confirmation: password
    )
  end

  private

  def notify_created
    UserNotifier.account_created(id, password).deliver
  end
end
