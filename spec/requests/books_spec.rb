require "rails_helper"

RSpec.describe BooksController, type: :request do
  let!(:book) { create (:book) }
  let(:valid_attributes) { attributes_for(:book) } 
  let(:invalid_attributes) { { title: "" } }
  let(:new_attributes) { { title: "NewTitle" } }


  describe "GET #index" do
  it "is successful" do
    get books_path

      expect(response).to be_successful
    end
  end

  describe "GET #show" do
  it "is successful" do
    get books_path

      expect(response).to be_successful
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
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "is successful" do
        expect do
          post books_path, params: { book: valid_attributes }
        end.to change(Book, :count).by(1)

      expect(response).to redirect_to(book_url(Book.last))
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

        expect(response).to redirect_to(book_url(book))
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
    end
   end  
end

