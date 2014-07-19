require 'spec_helper'

describe CategoryPresenter do
  let(:product_attribute) { create(:product_attribute) }
  let(:category) { product_attribute.category }
  let(:presenter) { CategoryPresenter.new(category_id: category.id, params: {}) }
  let(:brands) { Brand.joins("INNER JOIN products ON products.brand_id = brands.id AND products.category_id = #{category.id}") }
  describe '#products' do
    it 'should have products within category' do
      presenter.products.each do |p|
        p.category.should eq(category)
      end
    end
    it 'should show only active products' do
      presenter.products.each do |p|
        p.active.should be_true
      end
    end
  end

  describe '#category' do
    it 'should equal category passed in constructor' do
      presenter.category.should eq(category)
    end
  end
  describe '#product_attributes' do
    it 'should provide all avaliable attributes for current category' do
      presenter.product_attributes.should match_array([product_attribute])
    end
  end
  describe '#brands' do
    it 'should provide all avaliable brands for current category' do
      presenter.brands.should match_array(brands)
    end
  end
end
