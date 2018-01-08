class AddPhotoToDeputies < ActiveRecord::Migration[5.1]
  def change
    add_column :deputies, :photo, :string
  end
end
