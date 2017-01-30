class PersonPolicy < ApplicationPolicy
  def index?
    user
  end

  def show?
    user && user.author_of?(record)
  end

  def create?
    user
  end

  def new?
    create?
  end

  def update?
    user && user.author_of?(record)
  end

  def edit?
    update?
  end

  def destroy?
    user && user.author_of?(record)
  end
end