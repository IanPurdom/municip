class IndicationsController < ApplicationController
skip_before_action :verify_authenticity_token, only: [:create]
before_action :set_indication, only: [:update, :destroy]

  def create
    @question = Question.find(params[:question_id])
    @indication = Indication.new(indication_params)
    @indication.question_id = @question.id
    if @indication.save
      authorize @indication
      respond_to do |format|
        format.html {redirect_to questionnaire_path(@question.questionnaire_id)}
        format.js
      end
    else
      authorize @indication
      flash[:alert] = 'Un probléme est survenu'
      redirect_to questionnaire_path(@question.questionnaire_id)
    end
  end

  def update
    @indication.update(indication_params)
    if @indication.save
      authorize @indication
      respond_to do |format|
        format.html {redirect_to questionnaire_path(@indication.question.questionnaire_id)}
        format.js
      end
    else
      authorize @indication
      flash[:alert] = 'Un probléme est survenu'
      redirect_to questionnaire_path(@question.questionnaire_id)
    end
  end


  def destroy
    @indication.destroy
    respond_to do |format|
        format.html {redirect_to questionnaire_path(@indication.question.questionnaire_id)}
        format.js
    end
  end

  private

  def set_indication
    @indication = Indication.find(params[:id])
    authorize @indication
  end

    def indication_params
    params.require(:indication).permit(:indication)
  end

end
