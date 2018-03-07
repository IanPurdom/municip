class AnswersToQuestionsController < ApplicationController

  def new
    @question = Question.find(params[:question_id])
    @answers_to_question = AnswersToQuestion.new
    @answers = Answer.all
    authorize @answers_to_question
    redirect_to
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
