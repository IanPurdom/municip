class AnswersController < ApplicationController
before_action :set_answer, only: [:edit, :update, :destroy]

  def new
    @question = Question.find(params[:question_id])
    @questionnaire = @question.questionnaire_id
    @answer = Answer.new
    authorize @answer
  end

  def create
    @answer = Answer.new(answer: answer_params[:answer], question_id: params[:question_id] )
    @answer.save
    @questionnaire = @answer.question.questionnaire
    qs = @questionnaire.questions
    @questions = []
    @answer_ids = []
    qs.each do |q|
      @questions << q.question
      @answer_ids << q.answers.ids
    end
    @answer_ids = @answer_ids.flatten.sort
    @question_ids = @questionnaire.questions.ids
    authorize @answer
    respond_to do |format|
      format.html{redirect_to questionnaire_path(@answer.question.questionnaire)}
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
    authorize @answer
    @answer.destroy
    respond_to do |format|
      format.html{redirect_to questionnaire_path(@answer.question.questionnaire_id)}
      format.js
    end
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:answer, :next_question_id)
  end

end
