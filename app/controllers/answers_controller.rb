class AnswersController < ApplicationController
before_action :set_answer, only: [:edit, :update, :destroy]

  def new
    @question = Question.find(params[:question_id])
    @questionnaire = @question.questionnaire_id
    @answer = Answer.new
    authorize @answer
  end

  def create
    @answer = Answer.new(answer: answer_params[:answer], question_id: answer_params[:question_id], status: Status.find_by(status: "in_progress") )
    @answer.save
    authorize @answer
    @question = Question.find(answer_params[:question_id])
    respond_to do |format|
      format.html{redirect_to questions_new_path(:question_id=> @question.id, :answer_id => @answer.id)}
      format.js
    end
  end

  def edit
  end

  def update
    @answer.update(answer_params)
    @answer.save
    authorize @answer
    respond_to do |format|
      format.html{redirect_to questionnaire_path(@answer.question.questionnaire_id)}
      format.js
    end
  end

  def destroy
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:answer, :question_id, :next_question_id, :status_id)
  end

end
