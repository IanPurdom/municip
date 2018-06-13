class CreateRatioCommunes < ActiveRecord::Migration[5.1]
  def change
    create_table :ratio_communes do |t|
      t.string :name
      t.string :strate
      t.string :description
      t.float :ratio

      t.timestamps
    end
  end
end
