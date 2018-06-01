class RemoveEpciCoordinatesFromIntercomunalites < ActiveRecord::Migration[5.1]
  def change
    remove_column :intercommunalites, :epci_coordinates
  end
end
