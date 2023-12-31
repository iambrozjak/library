FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    username {Faker::Internet.username}
    first_name {Faker::Name.first_name }
    last_name {Faker::Name.last_name }
  end

  trait :shot_password do
    password { "123" }
  end
end
