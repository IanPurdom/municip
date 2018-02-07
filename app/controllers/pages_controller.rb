class PagesController < ApplicationController
  # skip_before_action :authenticate_user! #, only: [:home]
  # si commenté => même la home page nécéssite une authentification

  def home
    @city = City.where(user: current_user).first
    @deputies = policy_scope(Deputy).where(user: current_user)
    @categories = Category.all
    @questionnaires = Questionnaire.all
  end
end
