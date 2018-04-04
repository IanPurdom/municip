class PagesController < ApplicationController
  # skip_before_action :authenticate_user! #, only: [:home]
  # si commenté => même la home page nécéssite une authentification

  def home
    @city = City.where(user: current_user).first
    @photo = Photo.where(user: current_user).where.not(city_id: nil).first
    @photos = Photo.where.not(category_id: nil)
    @deputies = policy_scope(Deputy).where(user: current_user)
    @questionnaires = Questionnaire.all
    @interviews = policy_scope(Interview).where(user: current_user)
    # below is for the sortable questionnaire order functionality.
    #must pass the category. name to sortable.js using dataset function
    @categories = []
    @categories_names = []
    Questionnaire.distinct.pluck(:category_id).each do |category_id|
      category = Category.find(category_id)
      @categories << category
      @categories_names <<  category.name
    end
    @categories
    @categories_names
  end
end
