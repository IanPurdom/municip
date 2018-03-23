class QuestionnairesController < ApplicationController
before_action :set_questionnaire, only: [:show, :edit, :new_question, :destroy]

  def index
    @questionnaires = policy_scope(Questionnaire)
    @categories = Category.all
  end

  def new
    @questionnaire = Questionnaire.new
    @categories = Category.all
    authorize @questionnaire
  end

  def create
    @questionnaire = Questionnaire.new(questionnaire_params)
    @questionnaire.save
    authorize @questionnaire
    redirect_to questionnaire_path(@questionnaire)
  end

  def show
    authorize @questionnaire
    @answer = Answer.new
    @question = Question.new
  end

  def destroy
    authorize @questionnaire
    @questionnaire.destroy
    respond_to do |format|
      format.html{redirect_to root_path}
      format.js
    end
  end

  private

  def set_questionnaire
    @questionnaire = Questionnaire.find(params[:id])
  end

  def questionnaire_params
    params.require(:questionnaire).permit(:id, :title, :category_id)
  end

end
