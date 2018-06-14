class CreateCityRatios < ActiveRecord::Migration[5.1]
  def change
    create_table :city_ratios do |t|
      t.string :name
      t.float :ratio
      t.references :city, foreign_key: true

      t.timestamps
    end
  end
end
