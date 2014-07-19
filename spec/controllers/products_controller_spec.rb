require 'spec_helper'

describe ProductsController do
  let(:product) { create(:product) }

  describe 'GET show' do

    it 'should return categories page by SEO url' do
      get :show, id: product.id, seo_name: product.seo_name
      expect(response).to be_success
      expect(assigns(:product)).to eq(product)
    end

    it 'should redirect to SEO url if it exists' do
      get :show, id: product.id
      expect(response).to be_redirect
      expect(assigns(:product)).to eq(product)
    end

    it 'should return 404 if SEO url doesnt exist' do
      assert_raises(ActiveRecord::RecordNotFound) do
        get :show, id: product.id, seo_name: 'invalid_seo_name'
      end
    end

    it 'should return 404 if product is not active' do
      product.active = false
      product.save
      assert_raises(ActiveRecord::RecordNotFound) do
        get :show, id: product.id, seo_name: 'invalid_seo_name'
      end
    end

  end
end
