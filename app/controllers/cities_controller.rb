require 'open-uri' # Open an url
require "net/http"

class CitiesController < ApplicationController
before_action :set_city, only: [:show, :edit, :update, :destroy]

  def index
    @cities = policy_scope(City).where(user: current_user)
  end

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
      redirect_to cities_path
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

  def retrieve
    city = city_params[:name].split.map{|word| word.capitalize}.join(" ")
    my_url = "https://fr.wikipedia.org/wiki/#{city.gsub(" ", "_")}"
    # url = "https://fr.wikipedia.org/wiki/Les_Barils"


    if check_url(my_url)

      html = open(my_url).read
      html_doc = Nokogiri::HTML(html)

      city_details = []

      html_doc.search('.infobox_v2 tr').each do |tr|
        tr.search("th").each do |th|
          cells = tr.search ("td") if th != []
          city_details << cells.text.strip if cells.text != ""
        end
      end

      city_wiki = {
          name: city,
          region: city_details[1],
          canton: city_details[4],
          zip_code: city_details[7],
          code_commune: city_details[8],
          departement: city_details[2],
          intercommunalite: city_details[5],
          population:city_details[10],
          density: city_details[11],
          current_maire: city_details[6],
          gentile: city_details[9],
          coordinates:city_details[12],
          height: city_details[13],
          superficy: city_details[14],
          website: city_details[15]
      }


      @city = City.new(city_wiki)
      authorize @city
      respond_to do |format|
      format.html
      format.js
      end

    else

      @city = City.new
      authorize @city
      redirect_to new_city_path, notice: "Votre ville n'a pas été trouvée. Vérifiez l'écriture exacte sur wikipédia (trait d'union etc..)"

    end

  end

  private

  def set_city
    @city = City.find(params[:id])
    authorize @city
  end

  def city_params
    params.require(:city).permit(:id, :user_id, :name, :zip_code, :code_commune, :canton, :superficy, :website, :coordinates, :height, :gentile, :departement, :region, :intercommunalite, :population, :density, :debt, :current_maire, :photo_1, :photo_2, :photo_3 )
  end

  def check_url(my_url)
    url = URI.parse(my_url)
    req = Net::HTTP.new(url.host, url.port)
    req.use_ssl = true
    res = req.request_head(url.path)
    res.code == "200"
  end

end
