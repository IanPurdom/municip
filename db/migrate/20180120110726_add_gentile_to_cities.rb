class AddGentileToCities < ActiveRecord::Migration[5.1]
  def change
    add_column :cities, :gentile, :string
  end
end
