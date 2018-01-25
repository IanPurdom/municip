class RemovePhoto2ToCities < ActiveRecord::Migration[5.1]
  def change
    remove_column :cities, :photo_2, :string
  end
end
