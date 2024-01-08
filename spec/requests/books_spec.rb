require "rails_helper"

RSpec.describe BooksController, type: :request do
  include Devise::Test::IntegrationHelpers
  let!(:book) { FactoryBot.create(:book, :with_content) }
  let(:user) { create(:user) }
  let(:valid_attributes) { FactoryBot.attributes_for(:book) }
  let(:invalid_attributes) { FactoryBot.attributes_for(:book, :empty_title) }
  let(:new_attributes) { FactoryBot.attributes_for(:book, :new_title) }

  describe "GET #index" do
    it "is successful" do
      get books_path

      expect(response).to be_successful
      expect(response.body).to include(CGI.escapeHTML(book.title))
    end
  end

  describe "GET #show" do
    it "is successful" do
      get book_path(book)

      expect(response).to be_successful
      expect(response.body).to include(CGI.escapeHTML(book.title))
    end
  end

  describe "GET #new" do
    it "is successful" do
      get new_book_path

      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "is successful" do
      get edit_book_path(book)

      expect(response).to be_successful
      expect(response.body).to include(CGI.escapeHTML(book.title))
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "is successful" do
        expect do
          post books_path, params: { book: valid_attributes }
        end.to change(Book, :count).by(1)

        expect(response).to be_redirect
        expect(flash[:notice]).to eq("Book was successfully created.")
      end
    end

    context "with invalid parameters" do
      it "is not successful" do
        expect do
          post books_path, params: { book: invalid_attributes }
        end.to change(Book, :count).by(0)

        expect(response).to be_unprocessable
      end
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      it "is successful" do
        expect do
          patch book_path(book), params: { book: new_attributes }
          book.reload
        end.to change(book, :title).to(new_attributes[:title])

        expect(response).to redirect_to(book_path(book))
        expect(flash[:notice]).to eq("Book was successfully updated.")
      end
    end

    context "with invalid parameters" do
      it "is unprocessable" do
        expect do
          patch book_path(book), params: { book: invalid_attributes }
        end.not_to change(book, :title)

        expect(response).to be_unprocessable
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested book" do
      expect do
        delete book_path(book)
      end.to change(Book, :count).by(-1)

      expect(response). to redirect_to books_path
      expect(flash[:notice]).to eq("Book was successfully destroyed.")
    end
   end

   describe "GET #read" do
   context "user is authorized" do
     it "is successful" do
       sign_in user
       get read_book_path(book)

       expect(response).to be_successful
       expect(response.body).to include(book.content.filename.to_s)
     end
   end

   context "user is not authorized" do
     it "is successful" do
       get read_book_path(book)

       expect(response.body).not_to include(book.content.filename.to_s)
     end
   end
 end

end
