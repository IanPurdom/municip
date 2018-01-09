class ProgramsController < ApplicationController
before_action :set_program, only: [:show, :edit, :update, :destroy]

  def index
    @programs = policy_scope(Program)
  end

  def show
  end

  def new
    @program = Program.new
    @categories = Category.all
    authorize @program
  end

  def create
    @program = Program.new(program_params)
    authorize @program
    if @program.save
      redirect_to programs_path
    else
      @categories = Category.all
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
    params.require(:program).permit(:id, :title, :category_id, :content)
  end

end
