class ProgramsController < ApplicationController
before_action :set_program, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
    @programs = policy_scope(Program)
  end

  def show
  end

  def new
    @program = Program.new
    @answer = Answer.find(params[:answer_id])
    authorize @program
  end

  def create
    @answer = Answer.find(params[:answer_id])
    category = @answer.question.questionnaire.category
    @program = Program.new(content: program_params[:content], category: category, answer: @answer )
    authorize @program
    @program.save
      respond_to do |format|
        format.html{redirect_to questionnaire_path(@answer.question.questionnaire)}
        format.js
      end
  end

  def edit
    @categories = Category.all
  end

  def update
    authorize @program
    @program.update(program_params)
    # will send answer.id to update.js
    @answer = Answer.find(params[:answer_id])
    respond_to do |format|
      format.html{redirect_to questionnaire_path(@program.answers.first.question.questionnaire)}
      format.js
    end
  end

  def destroy
    @program.destroy
    redirect_to programs_path
  end

private

  def set_program
    @program = Program.find(params[:id])
    authorize @program
  end

  def program_params
    params.require(:program).permit(:title, :category_id, :content)
  end

end
