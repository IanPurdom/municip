class CreateIntercoCities < ActiveRecord::Migration[5.1]
  def change
    create_table :interco_cities do |t|
      t.references :city, foreign_key: true
      t.references :intercommunalite, foreign_key: true

      t.timestamps
    end
  end
end
