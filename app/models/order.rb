# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  code       :string(255)
#  state      :integer
#  note       :text
#  address_id :integer
#  created_at :datetime
#  updated_at :datetime
#




class Order < ActiveRecord::Base
  before_create :generate_shippment, :generate_invoice, :generate_code
  after_touch  :update_state
  belongs_to  :user
  has_one     :address
  has_one     :invoice, dependent: :destroy
  has_one     :shipment, dependent: :destroy
  has_many    :order_items, dependent: :destroy
  has_many    :order_histories, dependent: :destroy
  acts_as_taggable

  state_machine :state, :initial => :in_progress do
    state :in_progress, value: 0
    state :completed,   value: 1
    state :canceled,    value: 2

    # after_transition to: [:canceled, :in_progress] do |order, transition|
    #   OrderHistory.log_transition(transition)
    # end

    event :complete do
      transition :in_progress => :completed
    end

    event :cancel do
      transition [:in_progress, :completed] => :canceled, :if => lambda {|order| !order.shipment.shipped? && !order.invoice.paid?}
    end

    event :resume do
      transition :canceled => :in_progress
    end

    event :put_in_progress do
      transition :completed => :in_progress
    end
  end



  def self.build_from_cart(cart)
    order = Order.new
    cart.cart_items.each { |x|
      order.order_items.append(OrderItem.create(
                                 product_id: x.product_id,
                                 quantity: x.quantity,
                                 price: x.product.price
      ))
    }
    return order
  end

  def total_price
    self.order_items.collect{ |x| x.quantity * x.price }.inject(:+)
  end

  def previous
    Order.find_by_id(self.id - 1)
  end

  def next
    Order.find_by_id(self.id + 1)
  end

  private

  def update_state
    self.complete if self.invoice.paid? && self.shipment.shipped?
    self.put_in_progress if !self.invoice.paid? || !self.shipment.shipped? && self.completed?
  end

  def generate_shippment
    self.shipment = Shipment.new(address: self.address)
  end

  def generate_invoice
    self.invoice = Invoice.new(amount: self.total_price)
  end

  def generate_code
    self.code = SecureRandom.hex
  end

end
