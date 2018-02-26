class UserProgramsController < ApplicationController

  def create
    user_program = policy_scope(UserProgram).where("user_id = ? AND interview_id = ?",
    current_user.id, Interview.find(params[:interview_id]).id)
    # check if the answer has a program, flag is the title "no_prog"
    if Program.find(user_program_params[:program_id]).title.nil?
      user_program = UserProgram.new(program: user_program_params[:program], category_id: user_program_params[:category_id], question_id: user_program_params[:question_id] )
      user_program.user_id = current_user.id
      user_program.interview_id = params[:interview_id]
      if user_program.save
        if AnswersToQuestion.find(user_program_params[:a2q_id]).next_question_id.nil?
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
      if AnswersToQuestion.find(user_program_params[:a2q_id]).next_question_id.nil?
        authorize user_program
        redirect_to end_interview_interview_path(params[:interview_id])
      else
        authorize user_program
        redirect_to next_question_interview_path(params[:interview_id], user_program_params)
      end
    end
  end

  private

  def user_program_params
    params.require(:user_program).permit(:id, :program, :program_id, :category_id, :question_id, :a2q_id)
  end

end
