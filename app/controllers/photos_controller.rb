class PhotosController < ApplicationController

  def create
    @photo = Photo.create(photo_params)
    redirect_to cities_path
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to cities_path
  end

  private

  def photo_params
    params.require.(:photo).permit(:id, :city_id, :photo)
  end

end
