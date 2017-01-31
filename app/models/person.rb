class Person < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :good_weeks
  validates :fio, presence: :true
end
