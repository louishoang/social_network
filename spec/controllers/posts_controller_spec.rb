require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe "post to #create" do
    context "when user logged in" do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @user = FactoryGirl.create(:user)
        sign_in @user
      end
      it "create new post successfully" do
        _post = FactoryGirl.build(:post)
        
        post :create, :post => {content: _post.content, user_id: @user.id}, format: :json
        
        expect(response.body).to have_content("Post is created successfully")
        _new_post = Post.last
        expect(_new_post.content).to eq(_post.content)
      end
    end

    context "when user NOT login" do
      it "throw error" do
        _post = FactoryGirl.build(:post)
        
        post :create, :post => {content: _post.content, user_id: 1}, format: :json

        expect(response.body).to have_content("You need to sign in or sign up before continuing")
      end
    end
  end
end
