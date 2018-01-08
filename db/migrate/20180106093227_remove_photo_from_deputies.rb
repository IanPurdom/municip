class RemovePhotoFromDeputies < ActiveRecord::Migration[5.1]
  def change
    remove_column :deputies, :photo, :string
  end
end
