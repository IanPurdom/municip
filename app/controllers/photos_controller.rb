class PhotosController < ApplicationController

  def create
    @photo = Photo.new(photo_params)
    @photo.city_id = params[:city_id]
    @photo.save
    authorize @photo
    redirect_to city_path(params[:city_id])
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to city_path(@city)
  end

  private

  def photo_params
    params.require(:photo).permit(:photo)
  end

end
