class RemoveIntercommunaliteIdFromCity < ActiveRecord::Migration[5.1]
  def change
    remove_column :cities, :intercommunalite_id
  end
end
