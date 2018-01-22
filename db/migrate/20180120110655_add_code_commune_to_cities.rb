class AddCodeCommuneToCities < ActiveRecord::Migration[5.1]
  def change
    add_column :cities, :code_commune, :string
  end
end
