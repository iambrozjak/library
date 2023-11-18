class Book < ApplicationRecord
  has_one_attached :cover
  has_one_attached :content

  validates :title, :author, presence: true
  validates :isbn, presence: true, uniqueness: true,  numericality: { only_integer: true }, length: { is: 13 }
  validates :description, length: { maximum: 100 }

  scope :ordered, -> { order(:title) }
end
