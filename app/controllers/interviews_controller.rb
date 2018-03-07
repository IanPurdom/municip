class InterviewsController < ApplicationController
before_action :set_interview, only: [:show, :edit, :update, :destroy, :get_program, :next_question, :end_interview, :retry, :show_program]

  def index
    category_ids = Interview.distinct.pluck(:category_id)
    @categories = []
    category_ids.each do |id|
      @categories << Category.find(id)
    end
    @city = City.find_by(user: current_user)
    @interviews = policy_scope(Interview).where(user: current_user)
    @categories
    @deputies = Deputy.where(user: current_user)
  end

  def show
    if @interview.status.status == "in_progress"
      @question = Question.find(@interview.last_question_id)
      @user_program = UserProgram.new
      @answers = @question.answers
    else
      redirect_to show_program_interview_path(@interview)
    end
  end

  def create
    interviews = policy_scope(Interview).where("user_id = ? AND questionnaire_id = ?",
    current_user.id, Questionnaire.find(params[:questionnaire_id]).id)
    @questionnaire = Questionnaire.find(params[:questionnaire_id])
    @interview = Interview.new(user: current_user, questionnaire: @questionnaire, status: Status.find_by(status: "in_progress"), category: @questionnaire.category, order: @questionnaire.order)
    @interview.last_question_id = @interview.questionnaire.questions[0].id
    authorize @interview
    if @interview.save
      redirect_to interview_path(@interview)
    else
      redirect_to root_path
    end
  end

  def get_program
    p2a = ProgramToAnswer.find_by(answer_id: params[:answer])
      if p2a != nil
        # prog_id = p2a.program_id
        @program = Program.find(p2a.program_id)
        @answer_id = @program.program_to_answers[0].answer_id
      end
    @program
    authorize @interview
    respond_to do |format|
      format.html
      format.js
    end
  end

  def next_question
    #check on next_questio_id.nil already done in UserProgram Class,  method create
    p2a = ProgramToAnswer.find_by(program_id: params[:program_id])
    @a2q = Answer.find(p2a.answer_id)
    @next_question = Question.find(@a2q.next_question_id)
    #send the next_question id to interview.last_question in order to go back to the last question when we reopen the interview
    @interview.last_question_id = @next_question.id
    @interview.save
    @answers_instance = Answer.where(question_id: @next_question.id)
    @answer_ids =[]
    @answers = []
    # JS crash if calling > array.length ex: '<%= raw @answers[2].answer %>' thereofre need to do doo 2 array with ids and contents see next_question.js
    @answers_instance.each do |answer|
      @answer_ids << answer.id
      @answers << answer.answer
    end
    @answer_ids
    @answers
    authorize @interview
    respond_to do |format|
      format.html
      format.js
    end
  end

  def end_interview
    @interview.status = Status.find_by(status: "done")
    @interview.save
    respond_to do |format|
      format.html
      format.js
    end
  end

  def retry
    @user_program = UserProgram.where(interview: @interview)
    @user_program.destroy_all
    @interview.last_question_id = @interview.questionnaire.questions[0].id
    @interview.status = Status.find_by(status: "in_progress")
    @interview.save
    redirect_to interview_path(@interview)
  end

  def show_program
    @user_programs = @interview.user_programs
  end

  private

  def set_interview
    @interview = Interview.find(params[:id])
    authorize @interview
  end
end
