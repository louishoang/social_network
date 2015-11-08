require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  it 'is invalid without a email' do
    expect(build(:user, email: nil)).to_not be_valid
  end

  it 'has unique email' do
    3.times{FactoryGirl.create(:user)}
    user1 = User.first
    user2 = User.all[1]

    expect(user1.email).not_to eq(user2.email)
  end
end
