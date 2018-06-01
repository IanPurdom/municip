class AddCityCoordinatesToCity < ActiveRecord::Migration[5.1]
  def change
    add_column :cities, :city_coordinates, :json
  end
end
