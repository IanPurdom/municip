class PhotosController < ApplicationController

  def create
    @photo = Photo.create(city_id: params[:city_id], photo: params[:photo])
    authorize @photo
    redirect_to city_path(params[:city_id])
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to city_path(@city)
  end

  private

  # def photo_params
  #   params.require.(:city, :photo).permit(:city_id, :photo)
  # end

end
