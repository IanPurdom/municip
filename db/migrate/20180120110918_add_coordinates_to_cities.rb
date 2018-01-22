class AddCoordinatesToCities < ActiveRecord::Migration[5.1]
  def change
    add_column :cities, :coordinates, :string
  end
end
