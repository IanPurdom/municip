class AddIntercommunaliteToCities < ActiveRecord::Migration[5.1]
  def change
    add_reference :cities, :intercommunalite, foreign_key: true
  end
end
