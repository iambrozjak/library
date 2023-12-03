require "rails_helper"

RSpec.describe BooksController, type: :request do
  let!(:book) { FactoryBot.create :book }
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

  describe "GET #search" do
    context "when query is present and search parameters are actuall " do
      let(:query) { "Title" }

      before do
        allow(BooksIndex).to receive_message_chain(:query, :records).and_return([book])
        get search_books_path, params: { search: { query: query } }
      end

      it "returns a successful response" do
        expect(response).to be_successful
      end

      it "returns books matching the query" do
        expect(response.body).to include(book.title)
      end

      it "gets a flash notice with the number of found books" do
        expect(flash.now[:notice]).to eq("Found 1 books")
      end
    end

    context "when query is present but search parameters are wrong" do
      let(:query) { "Unknown_title" }

      before do
        allow(BooksIndex).to receive_message_chain(:query, :records).and_return([])
        get search_books_path, params: { search: { query: query } }
      end

      it "returns a successful response" do
        expect(response).to be_successful
      end

      it "not return any books" do
        expect(response.body).not_to include
      end

      it "gets a message that the book was not found" do
        expect(flash.now[:notice]).to eq("Books was not found.")
      end
    end

    context "when query is not present" do
      let(:query) { " " }

      before do
        get search_books_path, params: { search: { query: query } }
      end

      it "returns a successful response" do
        expect(response).to be_successful
      end

      it "gets a flash notice with a message about empty search parameters" do
        expect(flash.now[:notice]).to eq("Please, enter your search parameters.")
      end
    end
  end
end
