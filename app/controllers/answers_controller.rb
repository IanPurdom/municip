class AnswersController < ApplicationController

  def new
    @question = Question.find(params[:question_id])
    @answers = Answers.new
    authorize @answers
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
