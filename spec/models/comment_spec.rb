require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:post) }
    it { should belong_to(:user) }
  end

  it 'has a valid factory' do
    expect(build(:comment)).to be_valid
  end

  it 'is invalid without a content of text' do
    expect(build(:comment, text: nil)).to_not be_valid
  end

  it 'populate author name after save' do
    comment = FactoryGirl.create(:comment)
    expect(comment.author).to be_present
  end
end
