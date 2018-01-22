class ModifyDensityToCities < ActiveRecord::Migration[5.1]
  def change
    change_column :cities, :density, :string
  end
end
