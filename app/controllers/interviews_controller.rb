class InterviewsController < ApplicationController
before_action :set_interview, only: [:show, :edit, :update, :destroy, :get_program, :next_question]

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
    prog_id = ProgramToAnswer.find_by(answers_to_question_id: params[:answers_to_question]).program_id
    @program = Program.find(prog_id)
    @a2q_id = @program.program_to_answers[0].answers_to_question_id
    authorize @interview
    respond_to do |format|
      format.html
      format.js
    end
  end

  def next_question
    p2a = ProgramToAnswer.find_by(program_id: params[:program_id])
    @a2q = AnswersToQuestion.find(p2a.answers_to_question_id)
    authorize @interview
    if @a2q.next_question_id.nil?
      redirect_to root_path
    else
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
      @answers
      @a2q_ids
      respond_to do |format|
      format.html
      format.js
      end
    end
  end

  private
  def set_interview
    @interview = Interview.find(params[:id])
    authorize @interview
  end
end
