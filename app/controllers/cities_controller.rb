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

    #check if IntercoCommune already in DB
    if IntercoCommune.find_by(insee:@city.code_commune).nil?
      #get epci number and city coordinates from opendata API
      siren = RestClient.get "https://public.opendatasoft.com/api/records/1.0/search//?dataset=perimetre-groupements-siren-2017&q=insee%3D#{@city.code_commune}", {accept: :json}
      my_intercos = JSON.parse(siren)

      my_intercos["records"].each do |p|

       i = p["fields"]["insee"] unless p["fields"]["insee"].nil?
       sm = p["fields"]["siren_membres"] unless p["fields"]["siren_membres"].nil?
       sp = p["fields"]["siren_principal"] unless p["fields"]["siren_principal"].nil?
       geo = p["fields"]["geometry"]["coordinates"] unless p["fields"]["geometry"].nil?


      interco_commune = {
              siren_membre:sm,
              siren_principal:sp,
              insee:i,
              geometry:geo
      }

      IntercoCommune.create!(interco_commune)

      end
    end

    # we take the last element for the geolocalisation as it's the same for all of them
    city_coord = IntercoCommune.find_by(insee: @city.code_commune).geometry

    # with a : first array, b: second nested array, c: third nested array, d: fourth nested array

    unless city_coord == []
     @coordinates = []
      city_coord.each do |b|
        @city_sub_coordinates = []
        b.each do |c|
          if c.first.class == Float
            @city_sub_coordinates << {lat: c[1], lng: c[0]}
          else
            c.each do |d|
              @city_sub_coordinates << {lat: d[1], lng: d[0]}
            end
          end
        end
      @coordinates << @city_sub_coordinates
      end
    end

    @city.city_coordinates = @coordinates

    authorize @city

    if @city.save

    # get inteco epci number
      intercos = IntercoCommune.where(insee:@city.code_commune)

      for i in 0...intercos.count

        epci_number = intercos[i].siren_principal

        if Intercommunalite.find_by(epci_number: epci_number).nil?
        # get geojson interco

         #make api call to get the data
          siren = RestClient.get "https://public.opendatasoft.com/api/records/1.0/search//?dataset=groupements-collectivites-territoriales-2017&q=ndeg_siren%3D#{epci_number}", {accept: :json}
          epci = JSON.parse(siren)


          # clean the json, get rid of useless fields
          my_epci = epci["records"].first

          # with a : first array, b: second nested array, c: third nested array, d: fourth nested array

          unless my_epci["fields"]["st_asgeojson"].nil?
            a = my_epci["fields"]["st_asgeojson"]["coordinates"]
            @interco_coordinates = []
            a.each do |b|
              @sub_coordinates = []
                b.each do |c|
                  if c.count == 2
                    @sub_coordinates << {lat: c[1], lng: c[0]}
                  else
                    c.each do |d|
                      @sub_coordinates << {lat: d[1], lng: d[0]}
                    end
                  end
                end
              @interco_coordinates << @sub_coordinates
            end
          end

          unless my_epci["fields"]["geo_point_2d"].nil?
            markers_gross = my_epci["fields"]["geo_point_2d"]
            latitude = markers_gross[0].to_f
            longitude = markers_gross[1].to_f
          end

          # get the competences into an array

          unless my_epci["fields"]["competences"].nil?
            competences = my_epci["fields"]["competences"].split(",")
          end

          unless my_epci["fields"]["prenom_president"].nil? || my_epci["fields"]["nom_president"].nil?
            president_name = "#{my_epci["fields"]["prenom_president"] + " " + my_epci["fields"]["nom_president"]}"
          end

          @intercommunalite = Intercommunalite.create!(epci_number: intercos[i].siren_principal,
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

          @intercommunalite = Intercommunalite.find_by(epci_number: epci_number)

        end

        # then we make the link with city
        interco_city = IntercoCity.create(city_id: @city.id, intercommunalite_id: @intercommunalite.id)

      end #end fo i in

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
          website: city_details[15]
          # city_coordinates: @coordinates
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

