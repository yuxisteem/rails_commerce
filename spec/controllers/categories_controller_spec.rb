require 'spec_helper'

describe CategoriesController do
  let(:category) { create(:category) }

  describe 'GET show' do

    it 'should load category page by SEO url' do
      get :show, id: category.id, seo_name: category.seo_name
      expect(response).to be_success
      expect(assigns(:category).category).to eq(category)
    end

    it 'should redirect to SEO url if it exists' do
      get :show, id: category.id
      expect(response).to be_redirect
      expect(assigns(:category).category).to eq(category)
    end

    it 'should return 404 if SEO url doesnt exist' do
      assert_raises(ActiveRecord::RecordNotFound) do
        get :show, id: category.id, seo_name: 'bla-blah'
      end
    end

  end
end
