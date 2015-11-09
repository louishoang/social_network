require 'rails_helper'

RSpec.describe Connection, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:friend) }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:status) }
  end
end
