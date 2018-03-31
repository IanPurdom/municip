class QuestionnairePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user.role.role == "master"
  end

  def new?
    user.role.role == "master"
  end

  def show?
    user.role.role == "master"
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

  def root_question?
    user.role.role == "master"
  end

  def order_questionnaires?
    user.role.role == "master"
  end

end
