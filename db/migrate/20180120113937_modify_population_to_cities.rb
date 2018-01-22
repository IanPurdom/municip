class ModifyPopulationToCities < ActiveRecord::Migration[5.1]
  def change
    change_column :cities, :population, :string
  end
end
