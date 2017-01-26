class Book < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :good_weeks, join_table: 'books_good_weeks'
  validates :name, presence: :true
end
