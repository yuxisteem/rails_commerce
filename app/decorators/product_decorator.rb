class ProductDecorator < Draper::Decorator
  delegate_all
  def previous
    Product.find_by_id(id - 1)
  end

  def next
    Product.find_by_id(id + 1)
  end
end
