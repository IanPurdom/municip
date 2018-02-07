class QuestionnairesController < ApplicationController

  def index
    @questionnaires = policy_scope(Questionnaire)
    @categories = Category.all
  end

end
