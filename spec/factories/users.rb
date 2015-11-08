FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "#{n}#{Faker::Internet.email}"
    end
    # avatar_url Faker::Avatar.image("my-own-slug", "50x50")
    # first_name Faker::Name.first_name
    # last_name Faker::Name.last_name
    password "password"
    password_confirmation "password"
  end
end
