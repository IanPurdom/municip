class ProgramPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.role.role == "master"
  end

  def update?
    user.role.role == "master"
  end

  def destroy?
    user.role.role == "master"
  end

end
