class QuestionnairesController < ApplicationController
before_action :set_questionnaire, only: [:show, :edit, :update, :new_question, :destroy, :root_question]

  # def index
  #   @questionnaires = policy_scope(Questionnaire)
  #   @categories = Category.all
  # end

  def new
    @questionnaire = Questionnaire.new
    @categories = Category.all
    authorize @questionnaire
  end

  def create
    @questionnaire = Questionnaire.new(questionnaire_params)
    @questionnaire.activated = false
    @questionnaire.save
    authorize @questionnaire
    redirect_to questionnaire_path(@questionnaire)
  end

  def show
    authorize @questionnaire
    @answer = Answer.new
    @question = Question.new
    @categories = Category.all
  end

  def update
    authorize @questionnaire
    @questionnaire.update(questionnaire_params)
    @questionnaire.save
    respond_to do |format|
      format.html{redirect_to questionnaire_path(@questionnaire)}
      format.js
    end
  end

  def destroy
    authorize @questionnaire
    @questionnaire.destroy
    respond_to do |format|
      format.html{redirect_to root_path}
      format.js
    end
  end

  def root_question
    authorize @questionnaire
    @previous_root_question_id = @questionnaire.root_question_id
    @questionnaire.root_question_id = params[:question_id]
    @questionnaire.save
    respond_to do |format|
      format.html{redirect_to questionnaire_path(@questionnaire)}
      format.js
    end
  end

  def order_questionnaires
    @questionnaires = policy_scope(Questionnaire).where(category_id: questionnaire_params[:questionnaire_ids])
    questionnaire_params[:questionnaire_ids]
    quest_array = []
    questionnaire_params[:questionnaire_ids].split(" ").each {|id| quest_array << id.to_i}
    @questionnaire_ids = []
    @questionnaire_order = []
    quest_array.each_with_index do |id, index|
      q = Questionnaire.find(id)
      q.order = index + 1
      q.save
      @questionnaire_ids << id
      @questionnaire_order << q.order
      # must update the order for each interview belonging to the questionnaires
      interviews = Interview.where(questionnaire_id: id)
      interviews.each do |interview|
        interview.order = q.order
        interview.save
      end
    end
    respond_to do |format|
      format.html{redirect_to root_path}
      format.js
    end
  end

  private

  def set_questionnaire
    @questionnaire = Questionnaire.find(params[:id])
  end

  def questionnaire_params
    params.require(:questionnaire).permit(:id, :title, :category_id, :questionnaire_ids, :activated)
  end

end
