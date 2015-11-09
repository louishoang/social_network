require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  it 'has unique email' do
    3.times{FactoryGirl.create(:user)}
    user1 = User.first
    user2 = User.all[1]

    expect(user1.email).not_to eq(user2.email)
  end

  it "has a full name" do
    user = FactoryGirl.create(:user)

    expect(user.full_name).to be_present
  end

  it "has correct friend request" do
    connection = FactoryGirl.create(:connection)

    user1 = connection.user
    user2 = connection.friend

    expect(user1.has_friend_request?(user2)).to eq(true)
  end

  it "has pending request" do
    connection = FactoryGirl.create(:connection)

    user1 = connection.user
    user2 = connection.friend
    user3 = FactoryGirl.create(:user)

    expect(user2.pending_request).to be_present

    #ensure user3 has no connection
    expect(user3.pending_request).to be_empty
    expect(user3.has_friend_request?(user2)).to eql(false)
    expect(user3.has_friend_request?(user1)).to eql(false)
  end
end
