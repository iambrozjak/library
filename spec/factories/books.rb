FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author { Faker::Book.author }
    isbn { Faker::Number.number(digits: 13) }
    description { Faker::Book.genre }
  end
end
