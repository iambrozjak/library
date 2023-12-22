class BooksIndex < Chewy::Index
  index_name("books_#{Rails.env}")
  index_scope Book
  field :title
  field :author
  reset

end
