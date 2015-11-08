require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'has a valid factory' do
    expect(build(:post)).to be_valid
  end

  it 'is invalid without a content' do
    expect(build(:post, content: nil)).to_not be_valid
  end

  it 'is invalid without a user' do
    expect(build(:post, user_id: nil)).to_not be_valid
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
