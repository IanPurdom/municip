class QuestionsController < ApplicationController
before_action :set_question, only: [:show, :edit, :update, :destroy, :add_answer, :add_program ]

  def show
  end

  def new
    @questionnaire = Questionnaire.find(params[:questionnaire_id])
    @question = Question.new
    authorize @question
  end

  def create
    @question = Question.new(question_params)
    @question.questionnaire = Questionnaire.find(params[:questionnaire_id])
    @question.save
    @answer = Answer.new
    @question
    authorize @question
    respond_to do |format|
      format.html {redirect_to answers_new_path(:question_id => @question.id)}
      format.js
    end
  end

  def edit
    @question = Question.find(params[:question_id])
    authorize @question
  end

  def update
    @question.update(question_params)
  end

  def destroy
    @question.destroy
  end

  private

  def set_question
    @question = Question.find(params(:id))
  end

  def question_params
    params.require(:question).permit(:question)
  end
end
