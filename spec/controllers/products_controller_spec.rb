require 'spec_helper'

describe ProductsController do
  let(:product) { create(:product) }

  describe 'GET show' do

    it 'should return categories page by SEO url' do
      get :show, id: product.id, seo_name: product.seo_name
      expect(response).to be_success
      expect(assigns(:product)).to eq(product)
    end
  end
end
