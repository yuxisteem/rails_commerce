class OrderDecorator < Draper::Decorator
  delegate_all

  def total_price
    order_items.map { |x| x.quantity * x.price }.inject(:+)
  end

  def previous
    Order.find_by_id(id - 1)
  end

  def next
    Order.find_by_id(id + 1)
  end
end
