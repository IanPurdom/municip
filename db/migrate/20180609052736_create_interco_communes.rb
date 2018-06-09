class CreateIntercoCommunes < ActiveRecord::Migration[5.1]
  def change
    create_table :interco_communes do |t|
      t.string :siren_membre
      t.string :siren_principal
      t.string :insee
      t.json :geometry

      t.timestamps
    end
    add_index :interco_communes, :insee
  end
end

