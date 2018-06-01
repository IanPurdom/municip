class AddEpciCoordinatesToIntercommunalites < ActiveRecord::Migration[5.1]
  def change
    add_column :intercommunalites, :epci_coordinates, :json
  end
end
