class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @city = City.where(user: current_user).first
    @deputies = policy_scope(Deputy).where(user: current_user)
    @categories = Category.all
  end
end
