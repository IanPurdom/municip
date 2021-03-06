class InterviewsController < ApplicationController
before_action :set_interview, only: [:show, :edit, :update, :destroy, :get_program, :next_question, :end_interview, :retry, :show_program]

  def index
    category_ids = Interview.where(user: current_user).distinct.pluck(:category_id)
    @categories = []
    category_ids.each do |id|
      @categories << Category.find(id)
    end
    @city = City.find_by(user: current_user)
    @deputies = Deputy.where(user: current_user)
    @interviews = policy_scope(Interview).where(user: current_user).order(:order)
    @photos = Photo.where.not(category_id: nil)
  end

  def my_program
    @category = Category.find(params[:category_id])
    @interviews = policy_scope(Interview).where(user: current_user).where(category_id: @category).order(:order)
    @photos = Photo.where.not(category_id: nil)
    @city = City.find_by(user: current_user)
    @deputies = Deputy.where(user: current_user)
  end

  def show
    if @interview.status.status == "in_progress"
      @question = Question.find(@interview.last_question_id)
      @answers = @question.answers.order(:created_at)
    else
      redirect_to show_program_interview_path(@interview)
    end
  end

  def create
    @questionnaire = Questionnaire.find(params[:questionnaire_id])
    if @questionnaire.root_question_id.nil?
      authorize @questionnaire
      flash[:alert] = 'vous devez choisir une question racine'
      redirect_to questionnaire_path(@questionnaire)
    else
      interviews = policy_scope(Interview).where("user_id = ? AND questionnaire_id = ?",
      current_user.id, Questionnaire.find(params[:questionnaire_id]).id)
      @interview = Interview.new(user: current_user, questionnaire: @questionnaire, status: Status.find_by(status: "in_progress"), category: @questionnaire.category, order: @questionnaire.order)
      @interview.last_question_id = @questionnaire.root_question_id
      authorize @interview
      if @interview.save
        redirect_to interview_path(@interview)
      else
        redirect_to root_path
      end
    end
  end

  def get_program
    @answer = Answer.find(params[:answer])
    @content = @answer.program.content if @answer.program != nil
    authorize @interview
    respond_to do |format|
      format.html
      format.js
    end
  end

    # !!!!! for the rules check user_program_controller method: create!!!
  def next_question
    #check on next_question_id.nil already done in UserProgram Class,  method create
    @answer = Answer.find(params[:answer_id])
    @next_question = Question.find(@answer.next_question_id)
    #send the next_question id to interview.last_question in order to go back to the last question when we reopen the interview
    @interview.last_question_id = @next_question.id
    @interview.save
    @answers_instance = Answer.where(question_id: @next_question.id).order(:created_at)
    @answer_ids =[]
    @answers = []
    # JS crash if calling field with number > array.length ex: '<%= raw @answers[2].answer %>' thereofre need to do doo 2 array with ids and contents see next_question.js
    @answers_instance.each do |answer|
      @answer_ids << answer.id
      @answers << answer.answer
    end
    @answer_ids
    @answers
    @indication = @next_question.indications.first.indication if @next_question.indications != []
    authorize @interview
    respond_to do |format|
      format.html
      format.js
    end
  end

  def end_interview
    @interview.status = Status.find_by(status: "done")
    @interview.save
    @role = current_user.role.role
    respond_to do |format|
      format.html
      format.js
    end
  end

  def retry
    @user_program = UserProgram.where(interview: @interview)
    @user_program.destroy_all
    @questionnaire = @interview.questionnaire
    @interview.last_question_id = @questionnaire.root_question_id
    @interview.status = Status.find_by(status: "in_progress")
    @interview.save
    redirect_to interview_path(@interview)
  end

  def show_program
    @user_programs = @interview.user_programs
  end

  def destroy
    @questionnaire = @interview.questionnaire
    @interview.user_programs.destroy_all if @interview.user_programs != []
    @interview.destroy
    authorize @interview
    redirect_to questionnaire_path(@questionnaire)
  end

  private

  def set_interview
    @interview = Interview.find(params[:id])
    authorize @interview
  end

  def interview_params
    params.require(:interview).permit(:question_id)
  end
end
