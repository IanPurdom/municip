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
    @answer = Answer.find(program_params[:answer_id])
    category = @answer.question.questionnaire.category
    @program = Program.new(content: program_params[:content], category: category )
    authorize @program
    if @program.save
      @answer.status = Status.find_by(status: "done")
      @answer.save
      @program_to_answer = ProgramToAnswer.new(answer_id: @answer.id, program_id: @program.id)
      if @program_to_answer.save
      redirect_to questions_new_path(:question_id=> @answer.question.id, :answer_id=> @answer.id, :program_id=> @program.id)
      else render :new
      end
    else
      render :new
    end
  end

  def edit
    @categories = Category.all
  end

  def update
    @program.update(program_params)
    redirect_to programs_path
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
    params.require(:program).permit(:title, :category_id, :content, :answer_id)
  end

end
