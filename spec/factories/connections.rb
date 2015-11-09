FactoryGirl.define do
  factory :connection do
    association :user
    association :friend, factory: :user 
  end
end
