class QuestionsController < ApplicationController
skip_before_action :verify_authenticity_token, only: [:create]
before_action :set_question, only: [:show, :edit, :update, :destroy, :add_answer, :add_program ]

  def show
  end

  # def new
  #   if params[:question_id].nil?
  #     @questionnaire = Questionnaire.find(params[:questionnaire_id])
  #     @question = Question.new
  #   else
  #     @question = Question.find(params[:question_id])
  #     @answers = @question.answers.where(status: Status.find_by(status: "done"))
  #     if params[:answer_id].nil?
  #       @answer = Answer.new
  #     else
  #       @answer = Answer.find(params[:answer_id])
  #       if params[:program_id].nil?
  #         @program = Program.new
  #       else
  #         @program = Program.find(params[:program_id])
  #       end
  #     end
  #   end
  #   authorize @question
  # end

  def create
    @question = Question.new(question_params)
    @question.questionnaire = Questionnaire.find(params[:questionnaire_id])
    if @question.save
      @question
      authorize @question
      respond_to do |format|
        format.html {redirect_to questionnaire_path(@question.questionnaire)}
        format.js
      end
    else
      authorize @question
      render :new
      flash[:alert] = "La question est trop courte"
    end
  end

  # def edit
  #   @question = Question.find(params[:question_id])
  #   authorize @question
  # end

  def update
    authorize @question
    @question.update(question_params)
    respond_to do |format|
      format.html{redirect_to questionnaire_path(@question.questionnaire_id)}
      format.js
    end
  end

  def destroy
    authorize @question
    @question.destroy
    respond_to do |format|
      format.html{redirect_to questionnaire_path(@question.questionnaire_id)}
      format.js
    end
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:question)
  end

end
