require 'open-uri' # Open an url
require "net/http"
require 'uri'
require 'json'

class CitiesController < ApplicationController
before_action :set_city, only: [:show, :edit, :update, :destroy]

  def index
    @cities = policy_scope(City).where(user: current_user)
  end

  def show
    @photos = Photo.where(city_id: params[:id])
    @intercommunalite = Intercommunalite.find(@city.intercommunalite_id)

    unless @city.latitude.nil? || @city.longitude.nil?
         @markers = [{
            lat: @city.latitude,
            lng: @city.longitude#,
          # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
          }]
    end

  end

  def new
    @city = City.new
    authorize @city
  end

  def create

    @city = City.new(city_params)

    #get epci number and city coordinates

    filepath = "siren-2017.json"
    siren_serialized = open(filepath).read
    siren = JSON.parse(siren_serialized)

    num = []
    geo = []
    siren.each do |p|
      if p["fields"]["insee"] == "83073"
        num << p["fields"]["siren_principal"]
        geo <<  p["fields"]["geometry"]["coordinates"]
      end
    end

    city_coord = geo.first

    unless city_coord == []
     @coordinates = []
     coord.each do |c|
        @coordinates << {lat: c[1], lng: c[0]}
      end
    end

      @city.city_coordinates = @coordinates

    end

    #  get array with epcis with code_commune

    filepath = "epci.json"
    epci_serialized = open(filepath).read
    epci = JSON.parse(epci_serialized)

    my_epcis = epci.select do |p|
      num.include?p["fields"]["ndeg_siren"]
    end

    #we loop over each epci
    for my_epci in my_epcis
      #if doesnt exist we create it
      if Intercommunalite.find_by(epci_number: my_epci["fields"]["ndeg_siren"]).nil?
      # get geojson interco

        coord = my_epci["fields"]["geometry"]["coordinates"]

        unless coord == []
          @interco_coordinates = []
          coord.each do |c|
            @interco_coordinates << {lat: c[1], lng: c[0]}
          end
        end

        # get the competences into an array

        competences = my_epci["fields"]"competences".split(",")

        @intercommunalite = Intercommunalite.create(epci_number: my_epci["fields"]["ndeg_siren"],
                                                    epci_coordinates: @interco_coordinates,
                                                    name: my_epci["fields"]["nom_du_groupement"],
                                                    repartition_siege:my_epci["fields"]["mode_de_repartition_des_sieges"],
                                                    nature_juridique:my_epci["fields"]["nature_juridique"],
                                                    financement:my_epci["fields"]["mode_de_financement"],
                                                    siege:my_epci["fields"]["commune_siege"],
                                                    group_interdept:my_epci["fields"]["groupement_interdepartemental"],
                                                    date_creation:my_epci["fields"]["date_de_creation"],
                                                    nombre_membres:my_epci["fields"]["nombre_de_membres"],
                                                    population:my_epci["fields"]["population"],
                                                    nombre_competences:my_epci["fields"]["nombre_de_competences_exercees"],
                                                    president: my_epci["fields"]["prenom_president"] + my_epci["fields"]["nom_president"],
                                                    competences: competences
                                                    )

      else

        @intercommunalite = Intercommunalite.find_by(epci_number: @epci_number)

      end

      # then we make the link with city

      interco_city = IntercoCity.create(city_id: @city.id, intercommunalite_id: @intercommunalite.id)

    end #end du for my_epci

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
    Photo.where(city_id: @city.id).destroy_all if Photo.where(city_id: @city.id) != []
    @city.destroy
    redirect_to root_path
  end

  def retrieve

    # unless city_params[:name] =~ /-/i
    # city = city_params[:name].split.map{|word| word.capitalize}.join(" ")
    # end

    city = city_params[:name].sub!(", France", "")
    url = "https://fr.wikipedia.org/wiki/#{city.gsub(" ", "_")}"
    encoded_url = URI.encode(url)

    if check_url(encoded_url)

      # scrapping from wikipedia

      html = open(encoded_url).read
      html_doc = Nokogiri::HTML(html)

      city_details = []

      html_doc.search('.infobox_v2 tr').each do |tr|
        tr.search("th").each do |th|
          cells = tr.search ("td") if th != []
          city_details << cells.text.strip if cells.text != ""
        end
      end

      #get geocoding from geojson file

      unless city_details[8].nil?
        filepath = "db/polygon.json"
        serialized_polygons = File.read(filepath)
        polygons = JSON.parse(serialized_polygons)
        coord = []
        polygons["features"].each do |feature|
         coord = feature["geometry"]["coordinates"].flatten(1) if feature["properties"]["code"] == city_details[8]
        end

        coord

        unless coord == []
         @coordinates = []
         coord.each do |c|
            @coordinates << {lat: c[1], lng: c[0]}
          end
        end

      end

      city_wiki = {
          name: city,
          region: city_details[1],
          canton: city_details[4],
          zip_code: city_details[7],
          code_commune: city_details[8],
          departement: city_details[2],
          population:city_details[10],
          density: city_details[11],
          current_maire: city_details[6],
          gentile: city_details[9],
          coordinates:city_details[12],
          height: city_details[13],
          superficy: city_details[14],
          website: city_details[15],
          city_coordinates: @coordinates
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

  def check_url(my_url)
    url = URI.parse(my_url)
    req = Net::HTTP.new(url.host, url.port)
    req.use_ssl = true
    res = req.request_head(url.path)
    res.code == "200"
  end

  def set_city
    @city = City.find(params[:id])
    authorize @city
  end

  def city_params
    params.require(:city).permit(:id, :user_id, :name, :zip_code, :code_commune, :canton, :superficy, :website, :coordinates, :height, :gentile, :departement, :region, :intercommunalite, :population, :density, :debt, :current_maire)
  end

end

