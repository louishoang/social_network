require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe "get#index" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryGirl.create(:user)
      sign_in @user
    end
    it "gets a list of comments" do
      _post = FactoryGirl.create(:post)
      _comment = FactoryGirl.create(:comment, post_id: _post.id)
      _comment = FactoryGirl.create(:comment, post_id: _post.id)

      get :index, :post_id => _post.id

      assigns(@comments)["comments"].count.should eql(2)
    end

  end

  describe "post to #create" do
    context "when user logged in" do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @user = FactoryGirl.create(:user)
        sign_in @user
      end
      it "create new comment successfully" do
        _post = FactoryGirl.create(:post)
        _comment = FactoryGirl.build(:comment)
        
        post :create, :comment => {text: _comment.text, user_id: @user.id, :post_id => _post.id}, :post_id => _post.id, format: :json

        expect(response.body).to have_content("count")
        _new_comment = Comment.last
        expect(_new_comment.text).to eq(_comment.text)
      end
    end

    context "when user NOT login" do
      it "throw error" do
        _post = FactoryGirl.create(:post)
        _comment = FactoryGirl.build(:comment)
        
        post :create, :comment => {text: _comment.text, user_id: 1}, :post_id => _post.id, format: :json

        expect(response.body).to have_content("You need to sign in or sign up before continuing")
      end
    end
  end
end
