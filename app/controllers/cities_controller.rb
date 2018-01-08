class CitiesController < ApplicationController
before_action :set_city, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @city = City.new
    authorize @city
  end

  def create
    @city = City.new(city_params)
    @city.user = current_user
    authorize @city
    if @city.save
      redirect_to city_path(@city)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @city.update(city_params)
    redirect_to city_path(@city)
  end

  def destroy
    @city.destroy
    redirect_to root_path
  end

  private

  def set_city
    @city = City.find(params[:id])
    authorize @city
  end

  def city_params
    params.require(:city).permit(:id, :user_id, :name, :zip_code, :departement, :region, :intercommunalite, :population, :density, :debt, :current_maire, :photo_1, :photo_2, :photo_3 )
  end
end
