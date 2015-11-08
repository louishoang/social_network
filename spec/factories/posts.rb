FactoryGirl.define do
  factory :post do
    content Faker::Lorem.sentence(3)
    user
  end
end
