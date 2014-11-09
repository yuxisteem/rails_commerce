require 'spec_helper'

describe CategoriesHelper do

  let(:attribute) { create(:product_attribute_value) }
  let(:brand) { create(:brand) }

  before(:each) do
    controller.params[:seo_name] = 'mock_seo_name'
  end

  describe '#active_categories' do
    it 'should provide all categories list' do
      expect(helper.active_categories).to eq(Category.active)
    end
  end

  describe '#attribute_filter_link' do
    it 'should provide filter link for given attribute' do
      params[:id] = 999
      link = helper.attribute_filter_link(attribute)
      expect(link).to include(attribute.value)
      expect(link).to include(attribute.product_attribute_name_id.to_s)
    end

    it 'should append filter for attribute and preserve existing filters' do
      params[:id] = 999
      params[:q]  = { 2.to_s => ['AttributeValue2'] }

      link = helper.attribute_filter_link(attribute)
      expect(link).to include(attribute.value)
      expect(link).to include(attribute.product_attribute_name_id.to_s)

      expect(link).to include('AttributeValue2')
      expect(link).to include(2.to_s)
    end

    it 'should remove filter for attribute if filter is already active' do
      params[:id] = 999
      params[:q]  = { attribute.product_attribute_name_id.to_s => [attribute.value] }
      link = helper.attribute_filter_link(attribute)
      expect(link).to_not include(attribute.product_attribute_name_id.to_s)
      expect(link).to_not include('=#{attribute.value}')
    end
  end

  describe '#attribute_filter_active?' do
    it 'should be true if filter for attribute is active' do
      params[:q] = { attribute.product_attribute_name_id.to_s => [attribute.value] }
      expect(helper.attribute_filter_active?(attribute)).to be_truthy
    end

    it 'should be false if filter for attribute is not active' do
      expect(helper.attribute_filter_active?(attribute)).to be_falsey
    end
  end

  describe '#search_query' do
    it 'should not return search string on non-search results page' do
      expect(helper.search_query).to be_falsey
    end
  end

  describe '#brand_filter_link' do
    it 'should provide filter link for given brand' do
      params[:id] = 999
      link = helper.brand_filter_link(brand)
      expect(link).to include(brand.id.to_s)
    end

    it 'should remove filter for brand if filter is already active' do
      params[:id] = 999
      params[:brands]  = [brand.id.to_s]
      link = helper.brand_filter_link(brand)
      expect(link).to_not include(brand.id.to_s)
      expect(link).to_not include('brand')
    end
  end

  describe '#brand_filter_active?' do
    it 'should be true if filter for brand is active' do
      params[:brands] = [brand.id.to_s]
      expect(helper.brand_filter_active?(brand)).to be_truthy
    end
  end
end
