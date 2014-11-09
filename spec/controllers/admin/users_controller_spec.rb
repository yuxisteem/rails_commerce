require 'spec_helper'

describe Admin::UsersController do
	before(:each) do
	    sign_in(create(:admin))
	end

	describe "GET index" do
		it "should load users list" do
			get :index
			expect(response).to be_success
			expect(assigns(:users).count).to be_truthy
		end
	end

	describe "GET show" do
		it "should load user by id" do
			get :show, {id: User.first.id}
			expect(response).to be_success
			expect(assigns(:user)).to eq(User.first)
		end
	end

	describe "PATCH update" do
		it "should update user attributes" do
			user_id = create(:user).id
			params = {admin: true, first_name: 'New name', last_name: 'New last name', phone: '+123654789'}

			patch :update, {id: user_id, user: params}
			expect(response).to be_ok

			user = User.find(user_id)
			params.each {|key, value| expect(user.send(key)).to eq(value) }
		end
	end

	describe "DELETE destroy" do
		it "should delete user" do
			user = create(:user)

			user_id = user.id

			delete :destroy, {id: user_id}
			expect(response).to be_redirect

			expect(User.find_by_id(user_id)).to be_nil
		end
	end

end
