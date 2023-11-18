FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author { Faker::Book.author }
    isbn { Faker::Number.number(digits: 13) }
    description { Faker::Book.genre }
  end

  trait :empty_title do
    title { "" }
  end

  trait :new_title do
    title { "NewTitle" }
  end

  trait :with_cover do
    cover { Rack::Test::UploadedFile.new("spec/fixtures/cover_example.jpg", "image/jpeg") }
  end

  trait :with_content do
    content { Rack::Test::UploadedFile.new("spec/fixtures/content_example.pdf", "application/pdf") }
  end
end
