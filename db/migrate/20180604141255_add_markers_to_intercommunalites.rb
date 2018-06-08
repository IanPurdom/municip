class AddMarkersToIntercommunalites < ActiveRecord::Migration[5.1]
  def change
    add_column :intercommunalites, :latitude, :float
    add_column :intercommunalites, :longitude, :float
  end
end
