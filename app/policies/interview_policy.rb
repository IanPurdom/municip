class InterviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def get_program?
    record.user == user
  end

  def next_question?
    record.user == user
  end

end
