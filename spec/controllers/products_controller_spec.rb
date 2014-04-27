require 'spec_helper'

describe ProductsController do
  let(:product) { create(:product) }

  describe "GET show" do

    it "should return categories page" do
      get :show, {id: product.id}
      expect(response).to be_success
      expect(assigns(:product)).to eq(product)
    end

    pending "to be implemented" do
      it "should load category page by SEO url"  do
        get :show, {id: product.seo_name}
      end

      it "should redirect to SEO url if it exists" do
        get :show, {id: product.id}
      end

      it "should return 404 if SEO url doesnt exist" do
        get :show, {id: 'invalid-seo-url'}
      end
    end

  end
end
