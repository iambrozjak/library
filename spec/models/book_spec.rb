require 'rails_helper'

RSpec.describe Book, type: :model do

it  "should create  book" do
  book =  Book.create!(title:'Look to Windward', author:'Benjamin Wolf', isbn:'9372731109575', description:'Fantasy')
  expect(book.title).to eq ('Look to Windward')
end  

it  "should update title " do
  book =  Book.create!(title:'Look to Windward', author:'Benjamin Wolf', isbn:'9372731109575', description:'Fantasy')
  expect(book.title).to eq ('Look to Windward')
  book.title = 'New book'
  book.save
  expect(book.title).to eq ('New book')
end  


it  "should delete book" do
  book = Book.create!(title:'Look to Windward', author:'Benjamin Wolf', isbn:'9372731109575', description:'Fantasy')
  expect(book.title).to eq ('Look to Windward')
  book.destroy
  expect(Book.find_by(title: 'Look to Windward')).to be_nil
end

  
describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:author) }
    it { should validate_numericality_of(:isbn) }
    it { should validate_length_of( :description).is_at_most(100) }
    it { should validate_length_of( :isbn).is_equal_to(13) }
  end
end

