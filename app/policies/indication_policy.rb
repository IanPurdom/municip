class IndicationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
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
