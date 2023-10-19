require "faker"

(1..50).each do |id|
    Book.create(
        title: Faker::Book.title,
        author: Faker::Book.author,
        isbn: Faker::Number.number(digits: 13),
        description: Faker::Book.genre 
    )
end 