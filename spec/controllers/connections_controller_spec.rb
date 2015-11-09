require 'rails_helper'

RSpec.describe ConnectionsController, type: :controller do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user)
    sign_in @user
  end
  describe "post to #new" do
    context "when user logged in" do
      it "create new connection successfully" do
        user2 = FactoryGirl.create(:user)
        
        get :new, user_id: @user.id, friend_id: user2.id, format: :json

        expect(response.body).to have_content("Friend request sent")
        _connection = Connection.last
        expect(_connection.status).to eq(Connection::STATUS_PENDING)
      end
    end
  end
  describe "post to #update" do
    context "when user logged in" do
      it "update connection successfully" do
        connection = FactoryGirl.create(:connection)

        post :update, user_id: @user.id, id: connection.id, status: Connection::STATUS_ACTIVE, format: :json

        expect(response.body).to have_content(Connection::STATUS_ACTIVE)
        connection.reload
        expect(connection.status).to eq(Connection::STATUS_ACTIVE)
      end
    end
  end
end
