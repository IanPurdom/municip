class UserProgramsController < ApplicationController
before_action :set_user_program, only: [:edit, :update, :destroy]

  def create
    user_program = policy_scope(UserProgram).where("user_id = ? AND interview_id_id = ?",
    current_user.id, Interview.find(params[:interview_id]).id)
    # check if the answer has a program.
    #Program id is sent from simple_form in /interviews/show.html with field program_id and answer_id populated by get_program.js
    @answer = Answer.find(user_program_params[:answer_id])
    @program = Program.find(user_program_params[:program_id])
    if @program != nil?
      user_program = UserProgram.new(program: @program.content, category_id: @answer.question.questionnaire.category.id, question_id: @answer.question.id )
      user_program.user_id = current_user.id
      user_program.interview_id = params[:interview_id]
      if user_program.save
        #check if answer has next_question
        # if not, go to end_interview#interviews
        if @answer.next_question_id.nil?
          authorize user_program
          redirect_to end_interview_interview_path(params[:interview_id])
        # if yes, go to show#interviews => next_question
        else
          authorize user_program
          redirect_to next_question_interview_path(params[:interview_id], user_program_params)
        end
      # if not save, stay on current show#interview
      else
        authorize user_program
        redirect_to interview_path(params[:interview_id])
      end
    # if answer doesn't have program
    else
      #check if answer has next_question
        # if not, go to end_interview#interviews
      if @answer.next_question_id.nil?
        authorize user_program
        redirect_to end_interview_interview_path(params[:interview_id])
      # if yes, go to show#interviews => next_question
      else
        authorize user_program
        redirect_to next_question_interview_path(params[:interview_id], user_program_params)
      end
    end
  end


  def edit
  end

  def update
    @user_program.update(user_program_params)
    respond_to do |format|
      format.html {redirect_to show_program_interview_path(@user_program.interview_id)}
      format.js
    end
  end

  def destroy
    @user_program.destroy
    redirect_to interviews_path
  end

  private

  def set_user_program
    @user_program = UserProgram.find(params[:id])
    authorize @user_program
  end

  def user_program_params
    params.require(:user_program).permit(:program, :program_id, :answer_id)
  end

end
