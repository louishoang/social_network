require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  #show action is tested by feature test
  describe "post#update" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryGirl.create(:user)
      sign_in @user
    end
    it "update user info" do
      post :update, :id => @user.id, :user => {:first_name => "Louis", :last_name => "test"}

      @user.reload
      expect(@user.first_name).to eq("Louis")
      expect(@user.last_name).to eq("test")

      expect(response.body).to have_content("redirected")
    end

  end
end
