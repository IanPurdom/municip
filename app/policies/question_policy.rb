class QuestionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    true
  end

  def new
    true
  end

  def create?
    true
  end

  def update?
    true
  end

  def destroy?
    update?
  end

end