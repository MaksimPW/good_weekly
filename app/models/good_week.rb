class GoodWeek < ApplicationRecord
  validates :monday, presence: true

  def number_of_year
    monday.cweek
  end

  def sunday
    monday.end_of_week
  end
end
