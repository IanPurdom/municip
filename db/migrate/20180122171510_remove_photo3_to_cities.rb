class RemovePhoto3ToCities < ActiveRecord::Migration[5.1]
  def change
    remove_column :cities, :photo_3, :string
  end
end
