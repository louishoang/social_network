require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:content) }
    it { should validate_length_of(:content).is_at_least(1) }
    it { should validate_length_of(:content).is_at_most(1000) }
    it { should validate_presence_of(:user) }
  end

  it 'has a valid factory' do
    expect(build(:post)).to be_valid
  end

  it 'is invalid without a user' do
    expect(build(:post, user_id: nil)).to_not be_valid
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
