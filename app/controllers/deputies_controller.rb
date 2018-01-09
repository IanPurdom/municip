class DeputiesController < ApplicationController

before_action :set_deputy, only: [:show, :edit, :update, :destroy]

  def index         # GET /deputies
    @deputies = policy_scope(Deputy).where(user: current_user)
  end

  def show          # GET /deputies/:id
  end

  def new           # GET /deputies/new
    @deputy = Deputy.new
    authorize @deputy
  end

  def create        # POST /deputies
    raise
    @deputy = Deputy.new(deputy_params)
    @deputy.user = current_user
    authorize @deputy
    if @deputy.save
      redirect_to deputies_path
    else
      render :new
    end
  end

  def edit          # GET /deputies/:id/edit
  end

  def update        # PATCH /deputies/:id
  end

  def destroy       # DELETE /deputies/:id
    @deputy.destroy
    redirect_to deputies_path
  end

 private

  def set_deputy
    @deputy = Deputy.find(params[:id])
    authorize @deputy
  end

  def deputy_params
    params.require(:deputy).permit(:id, :first_name, :last_name, :title, :profession, :user_id, :photo)
  end

end
