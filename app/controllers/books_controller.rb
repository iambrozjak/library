class BooksController < ApplicationController
  def index
    @books = collection
  end

  def show
    @book = resourse
  end

  def new
    @book = Book.new
  end

  def edit
    @book = resourse
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book)
    else
      flash[:alert] = "Book was not created."
      render :new, status: :unprocessable_entity
    end    
  end

  def update
    @book = resourse

    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    resourse.destroy
    flash[:notice] = "Book was successfully destroyed."
    redirect_to books_path, status: :see_other
  end

  private

  def book_params
      params.require(:book).permit(:title, :author, :isbn, :description)
  end

  def collection
    Book.ordered
  end

  def resourse
    collection.find(params[:id])
  end
end
