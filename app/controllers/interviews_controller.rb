class InterviewsController < ApplicationController
before_action :set_interview, only: [:show, :edit, :update, :destroy, :get_program, :next_question, :end_interview]

  def show
    @question = @interview.questionnaire.questions[0]
    @user_program = UserProgram.new
  end

  def create
    interviews = policy_scope(Interview).where("user_id = ? AND questionnaire_id = ?",
    current_user.id, Questionnaire.find(params[:questionnaire_id]).id)
    if interviews.any?
      @interview = interviews.first
      authorize @interview
      redirect_to interview_path(@interview)
    else
      @interview = Interview.new
      @interview.user = current_user
      @interview.questionnaire = Questionnaire.find(params[:questionnaire_id])
      authorize @interview
      if @interview.save
        redirect_to interview_path(@interview)
      else
        redirect_to root_path
      end
    end
  end

  def get_program
    p2a = ProgramToAnswer.find_by(answers_to_question_id: params[:answers_to_question])
      if p2a != nil
        prog_id = p2a.program_id
        @program = Program.find(prog_id)
        @a2q_id = @program.program_to_answers[0].answers_to_question_id
      end
    authorize @interview
    respond_to do |format|
      format.html
      format.js
    end
  end

  def next_question
    #check on next_questio_id.nil already done in UserProgram Class,  method create
    p2a = ProgramToAnswer.find_by(program_id: params[:program_id])
    @a2q = AnswersToQuestion.find(p2a.answers_to_question_id)
    @next_question = Question.find(@a2q.next_question_id)
    # get the a2q id to send to ajax for href update
    # because we dont'necessarly have the same answers for each question: yes, no, don't know etc..
    a2q_next = AnswersToQuestion.where(question_id: @next_question.id)
    @answers = []
    @a2q_ids = []
    a2q_next.each do |a2q|
      answer_id = a2q.answer_id
      @answers << Answer.find(answer_id).answer
      @a2q_ids << a2q.id
    end
    authorize @interview
    @answers
    @a2q_ids
    respond_to do |format|
      format.html
      format.js
    end
  end

  def end_interview
    respond_to do |format|
      format.html
      format.js
      end
  end

  private
  def set_interview
    @interview = Interview.find(params[:id])
    authorize @interview
  end
end
