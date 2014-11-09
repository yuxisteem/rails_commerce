require 'spec_helper'

describe CategoryPresenter do
  let(:product_attribute_name) { create(:product_attribute_name) }
  let(:category) { product_attribute_name.category }
  let(:presenter) { CategoryPresenter.new(category, params: {}) }
  let(:brands) { Brand.joins("INNER JOIN products ON products.brand_id = brands.id AND products.category_id = #{category.id}") }
  describe '#products' do
    it 'should have products within category' do
      presenter.products.each do |p|
        expect(p.category).to eq(category)
      end
    end
    it 'should show only active products' do
      presenter.products.each do |p|
        expect(p.active).to be_truthy
      end
    end
  end

  describe '#category' do
    it 'should equal category passed in constructor' do
      expect(presenter.id).to eq(category.id)
    end
  end
  describe '#product_attributes' do
    it 'should provide all avaliable attributes for current category' do
      expect(presenter.product_attribute_names).to match_array([product_attribute_name])
    end
  end
  describe '#brands' do
    it 'should provide all avaliable brands for current category' do
      expect(presenter.brands).to match_array(brands)
    end
  end
end
