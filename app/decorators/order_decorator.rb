class OrderDecorator < Draper::Decorator
  delegate_all

  def next
    Order.where('id > ?', id).first
  end

  def previous
    Order.where('id < ?', id).last
  end
end
