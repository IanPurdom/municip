class AddEpciCoordinatesiToCity < ActiveRecord::Migration[5.1]
  def change
    add_column :cities, :epci_coordinates, :json
  end
end
