class UserProgramPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
   true
  end

  def edit?
    record.user == user
  end

  def update?
    record.user == user
  end

  def destroy?
    if user.role.role == "user"
      record.user == user
    else
      user.role.role == "master"
    end
  end

end
