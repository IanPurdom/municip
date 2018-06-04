require 'open-uri' # Open an url
require "net/http"
require 'uri'
require 'json'

class CitiesController < ApplicationController
before_action :set_city, only: [:show, :edit, :update, :destroy, :show_interco]

  def index
    @cities = policy_scope(City).where(user: current_user)
  end

  def show
    @photos = Photo.where(city_id: params[:id])

    unless @city.latitude.nil? || @city.longitude.nil?
         @markers = [{
            lat: @city.latitude,
            lng: @city.longitude#,
          # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
          }]
    end

  end

  def show_interco

    unless params[:epci_number].nil?
      @intercommunalite = Intercommunalite.find_by(epci_number: params[:epci_number])
    end

    unless @intercommunalite.latitude.nil? || @intercommunalite.longitude.nil?
         @markers = [@intercommunalite.latitude, @intercommunalite.longitude]
    end

    authorize @city
    respond_to do |format|
      format.html {redirect_to city_path(@city)}
      format.js
    end
  end

  def new
    @city = City.new
    authorize @city
  end

  def create

    @city = City.new(city_params)
    @city.user = current_user

    #get epci number and city coordinates from siren file

    filepath = "db/siren-2017.json"
    siren_serialized = open(filepath).read
    siren = JSON.parse(siren_serialized)

    epcis_number = []
    city_coord = []
    siren.each do |p|
      if p["fields"]["insee"] == @city.code_commune
        epcis_number << p["fields"]["siren_principal"]
        city_coord <<  p["fields"]["geometry"]["coordinates"]
      end
    end

    #need to check if 4 nested array in json siren file
    if city_coord.flatten(2).count < 70
      i = 3
    else
      i = 2
    end

    unless city_coord == []
     @coordinates = []
     city_coord.flatten(i).each do |c|
        @coordinates << {lat: c[1], lng: c[0]}
      end
    end

    @city.city_coordinates = @coordinates

    authorize @city
    if @city.save
    #  get array with epcis with code_commune (epcis_number aray from above)

      filepath = "db/epci.json"
      epci_serialized = open(filepath).read
      epci = JSON.parse(epci_serialized)

      my_epcis = epci.select do |p|
        epcis_number.include?p["fields"]["ndeg_siren"]
      end

      #we loop over each epci
      for my_epci in my_epcis
        #if doesnt exist we create it
        if Intercommunalite.find_by(epci_number: my_epci["fields"]["ndeg_siren"]).nil?
        # get geojson interco

          coord = my_epci["fields"]["st_asgeojson"]["coordinates"]

          #need to check if 4 nested array in json file
          if coord.flatten(1).count < 70
            n = 2
          else
            n = 1
          end

          unless coord == []
            @interco_coordinates = []
            coord.flatten(n).each do |c|
              @interco_coordinates << {lat: c[1], lng: c[0]}
            end
          end

          markers_gross = my_epci["geometry"]["coordinates"]
          unless markers_gross.nil?
            latitude = markers_gross[1].to_f
            longitude = markers_gross[0].to_f
          end

          # get the competences into an array

          unless my_epci["fields"]["competences"].nil?
            competences = my_epci["fields"]["competences"].split(",")
          end

          unless my_epci["fields"]["prenom_president"].nil? || my_epci["fields"]["nom_president"].nil?
          president_name = "#{my_epci["fields"]["prenom_president"] + " " + my_epci["fields"]["nom_president"]}"
          end

          @intercommunalite = Intercommunalite.create!(epci_number: my_epci["fields"]["ndeg_siren"],
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
                                                      president: president_name,
                                                      competences: competences,
                                                      latitude: latitude,
                                                      longitude: longitude
                                                      )



        else

          @intercommunalite = Intercommunalite.find_by(epci_number: my_epci["fields"]["ndeg_siren"])

        end

        # then we make the link with city
        interco_city = IntercoCity.create(city_id: @city.id, intercommunalite_id: @intercommunalite.id)

      end #end du for my_epci

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
    params.require(:city).permit(:id, :user_id, :name, :zip_code, :code_commune, :canton, :superficy, :website, :coordinates, :height, :gentile, :departement, :region, :intercommunalite, :population, :density, :debt, :current_maire, :epci_number)
  end

end

