require 'spec_helper'

describe CategoriesController do
  let(:category) { create(:category) }

  describe "GET show" do

    it "should return categories page" do
      get :show, {id: category.id}
      expect(response).to be_success
      expect(assigns(:presenter).category).to eq(category)
    end

    pending "to be implemented" do
      it "should load category page by SEO url"  do
        get :show, {id: category.seo_name}
      end

      it "should redirect to SEO url if it exists" do
        get :show, {id: category.id}
      end

      it "should return 404 if SEO url doesnt exist" do
        get :show, {id: 'invalid-seo-url'}
      end
    end

  end
end
