class AnswersController < ApplicationController

  def new
    @question = Question.find(params[:question_id])
    @questionnaire = @question.questionnaire_id
    @answer = Answer.new
    authorize @answer
  end

  def create
    @answer = Answer.new(answer: answer_params[:answer], question_id: answer_params[:question_id] )
    @answer.save
    authorize @answer
    @question = Question.find(answer_params[:question_id])
    respond_to do |format|
      format.html{redirect_to new_program_path(:answer_id => @answer.id)}
      format.js
    end  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def answer_params
    params.require(:answer).permit(:answer, :question_id, :questionnaire_id)
  end
end
