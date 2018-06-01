class RemoveIntercommunaliteFromCities < ActiveRecord::Migration[5.1]
  def change
    remove_column :cities, :intercommunalite
  end
end
