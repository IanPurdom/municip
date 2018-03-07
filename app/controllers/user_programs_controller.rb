class UserProgramsController < ApplicationController
before_action :set_user_program, only: [:edit, :update, :destroy]

  def create
    user_program = policy_scope(UserProgram).where("user_id = ? AND interview_id = ?",
    current_user.id, Interview.find(params[:interview_id]).id)
    # check if the answer has a program, flag is the title "no_prog"
    if Program.find(user_program_params[:program_id]).title.nil?
      user_program = UserProgram.new(program: user_program_params[:program], category_id: user_program_params[:category_id], question_id: user_program_params[:question_id] )
      user_program.user_id = current_user.id
      user_program.interview_id = params[:interview_id]
      if user_program.save
        if Answer.find(user_program_params[:a2q_id]).next_question_id.nil?
          authorize user_program
          redirect_to end_interview_interview_path(params[:interview_id])
        else
          authorize user_program
          redirect_to next_question_interview_path(params[:interview_id], user_program_params)
        end
      else
        authorize user_program
        redirect_to interview_path(params[:interview_id])
      end
    else
      if Answer.find(user_program_params[:a2q_id]).next_question_id.nil?
        authorize user_program
        redirect_to end_interview_interview_path(params[:interview_id])
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
    redirect_to show_program_interview_path(user_program_params[:interview_id])
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
    params.require(:user_program).permit(:id, :interview_id, :program, :program_id, :category_id, :question_id, :a2q_id)
  end

end
