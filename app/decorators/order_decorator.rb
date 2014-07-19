class OrderDecorator < Draper::Decorator
  delegate_all

  def previous
    Order.find_by_id(id - 1)
  end

  def next
    Order.find_by_id(id + 1)
  end
end
