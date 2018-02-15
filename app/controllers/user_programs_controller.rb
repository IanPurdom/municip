class UserProgramsController < ApplicationController
  def create
    user_program = UserProgram.new(program: user_program_params[:program], category_id: user_program_params[:category_id], question_id: user_program_params[:question_id] )
    user_program.user_id = current_user.id
    user_program.interview_id = params[:interview_id]
    authorize user_program
    if user_program.save
      if AnswersToQuestion.find(user_program_params[:a2q_id]).next_question_id.nil?
        redirect_to root_path
      else
        redirect_to next_question_interview_path(params[:interview_id], user_program_params)
      end
    else
      redirect_to interview_path(params[:interview_id])
    end
  end

  private

  def user_program_params
    params.require(:user_program).permit(:id, :program, :program_id, :category_id, :question_id, :a2q_id)
  end

end
