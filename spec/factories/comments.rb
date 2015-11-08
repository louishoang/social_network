FactoryGirl.define do
  factory :comment do
    text Faker::Lorem.sentence(3)
    association :post
    association :user, factory: :user 
  end
end
