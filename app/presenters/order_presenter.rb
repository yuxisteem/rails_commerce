class OrderPresenter
  include ActiveModel::Model

  attr_accessor :first_name, :last_name, :email, :note, :phone, :street, :city

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 50 },
                    format: { with: VALID_EMAIL_REGEX }
  validates :phone, presence: true, length: { maximum: 20 }
  validates :street, presence: true, length: { maximum: 255 }
  validates :city, presence: true, length: { maximum: 255 }
  validates :note, length: { maximum: 1024 }

  def address
    Address.new(phone: phone,
                street: street,
                city: city)
  end

  def address=(address)
    return unless address
    @city = address.city
    @street = address.street
    @phone = address.phone
  end

  def update(attributes_hash = {})
    attributes_hash ||= {}
    attributes_hash.each do |name, value|
      name = name.to_s
      send("#{name}=", value)
    end
  end

  def build_order(cart, user)
    user.update(first_name: first_name,
                last_name: last_name,
                phone: phone)

    @order = Order.build_from_cart(cart)
    @order.update(address: address, note: note, user: user)
    @order
  end

end
