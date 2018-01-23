class RemovePhoto1ToCities < ActiveRecord::Migration[5.1]
  def change
    remove_column :cities, :photo_1, :string
  end
end
