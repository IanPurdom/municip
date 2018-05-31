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
    @coordinates = @city.city_coordinates

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
    @city.user = current_user

    #get geocoding from json polugon file

    unless @city.code_commune.nil?
      filepath = "db/polygon.json"
      serialized_polygons = File.read(filepath)
      polygons = JSON.parse(serialized_polygons)
      coord = []
      polygons["features"].each do |feature|
       coord = feature["geometry"]["coordinates"].flatten(1) if feature["properties"]["code"] == @city.code_commune
      end

      coord

      unless coord == []
       @coordinates = []
       coord.each do |c|
          @coordinates << {lat: c[1], lng: c[0]}
        end
      end

      @city.city_coordinates = @coordinates

    end


    # get EPCI interco number

    filepath = "db/intercommunalite_2017.json"
    interco_serialized = open(filepath).read
    interco = JSON.parse(interco_serialized)

    interco.each do |p|
      if p["fields"]["codgeo"] == @city.code_commune
        @epci_number = p["fields"]["epci"]
        @intercommunalite_name = p["fields"]["libepci"]
      end
    end

    #if epci exist or not DB
    unless @epci_number.nil?

      if Intercommunalite.find_by(epci_number: @epci_number).nil?

        # get geojson interco

        filepath = "db/contours_epci_2017.json"
        epci_serialized = open(filepath).read
        epci = JSON.parse(epci_serialized)

        coord = []
        epci.each do |p|
          coord = p["fields"]["geo_shape"]["coordinates"].flatten(1) if p["fields"]["siren_epci"] == @epci_number
        end

        unless coord == []
         @interco_coordinates = []
         coord.each do |c|
            @interco_coordinates << {lat: c[1], lng: c[0]}
          end
        end

        @intercommunalite = Intercommunalite.create(epci_number: @epci_number, epci_coordinates: @interco_coordinates, name: @intercommunalite_name)


      else

        @intercommunalite = Intercommunalite.find_by(epci_number: @epci_number)

      end
    end

    @city.intercommunalite_id = @intercommunalite.id


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

