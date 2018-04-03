class PhotosController < ApplicationController
before_action :set_photo, only: [:destroy]

  def create
    @photo = Photo.new(photo_params)
    @photo.user = current_user
    @photo.save
    authorize @photo
    if photo_params[:city_id].nil?
      redirect_to interviews_path
    else
      redirect_to city_path(photo_params[:city_id])
    end
  end

  def destroy
    @photo.destroy
    authorize @photo
    if params[:city_id].nil?
      redirect_to interviews_path
    else
      redirect_to city_path(params[:city_id])
    end
  end

  private

  def set_photo
   @photo = Photo.find(params[:id])
   authorize @photo
  end

  def photo_params
    params.require(:photo).permit(:photo, :category_id, :city_id)
  end

end
