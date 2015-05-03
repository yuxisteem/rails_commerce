require 'spec_helper'

describe CategoriesController do
  let(:category) { create(:category) }

  describe 'GET show' do

    it 'should load category page by SEO url' do
      get :show, id: category.to_param
      expect(response).to be_success
      expect(assigns(:category).category).to eq(category)
    end
  end
end
