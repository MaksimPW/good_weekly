class GoodWeek < ApplicationRecord
  validates :monday, presence: true
  belongs_to :user
  has_and_belongs_to_many :books, join_table: 'books_good_weeks'

  def self.find_by_number_of_year_and_week(year, week)
    monday = Date.commercial(year.to_i, week.to_i, 1)
    self.find_by_monday(monday)
  end

  def number_of_year
    monday.cweek
  end

  def sunday
    monday.end_of_week
  end

  def year
    monday.year
  end
end
