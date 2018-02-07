class InterviewsController < ApplicationController
before_action :set_interview, only: [:show, :edit, :update, :destroy]

  def show
    authorize @interview
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

  private
  def set_interview
    @interview = Interview.find(params[:id])
    authorize @interview
  end

end
