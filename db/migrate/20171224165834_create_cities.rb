class CreateCities < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.references :user, foreign_key: true
      t.integer :zip_code
      t.string :departement
      t.string :region
      t.string :intercommunalite
      t.integer :population
      t.integer :density
      t.integer :debt
      t.string :current_maire
      t.string :photo_1
      t.string :photo_2
      t.string :photo_3

      t.timestamps
    end
  end
end
