class QuestionsController < ApplicationController

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
    authorize @question
    redirect_to new_question_answers_to_question_path(@question)
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

  def question_params
    params.require(:question).permit(:question)
  end
end
