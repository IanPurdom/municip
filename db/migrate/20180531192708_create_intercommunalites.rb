class CreateIntercommunalites < ActiveRecord::Migration[5.1]
  def change
    create_table :intercommunalites do |t|
      t.string :epci_number
      t.string :epci_coordinates
      t.string :name

      t.timestamps
    end
  end
end
