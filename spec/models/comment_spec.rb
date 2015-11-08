require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:text) }
    it { should validate_length_of(:text).is_at_least(1) }
    it { should validate_length_of(:text).is_at_most(250) }
    it { should validate_presence_of(:user) }
  end

  describe 'associations' do
    it { should belong_to(:post) }
    it { should belong_to(:user) }
  end

  it 'has a valid factory' do
    expect(build(:comment)).to be_valid
  end

  it 'populate author name after save' do
    comment = FactoryGirl.create(:comment)
    expect(comment.author).to be_present
  end
end
