class PhotosController < ApplicationController
before_action :set_photo, only: [:destroy]

  def create
    @photo = Photo.new(photo_params)
    @photo.city_id = params[:city_id]
    @photo.save
    authorize @photo
    redirect_to city_path(params[:city_id])
  end

  def destroy
    @photo.destroy
    authorize @photo
    redirect_to city_path(params[:city_id])
  end

  private

  def set_photo
   @photo = Photo.find(params[:id])
   authorize @photo
  end

  def photo_params
    params.require(:photo).permit(:photo)
  end

end
