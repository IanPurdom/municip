class RemovePopulationFromCities < ActiveRecord::Migration[5.1]
  def change
    remove_column :cities, :population, :string
  end
end
