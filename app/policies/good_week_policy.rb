class GoodWeekPolicy < ApplicationPolicy
  def current_week?
    user && user.author_of?(record)
  end

  def show?
    user && user.author_of?(record)
  end
end