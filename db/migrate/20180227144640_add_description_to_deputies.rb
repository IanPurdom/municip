class AddDescriptionToDeputies < ActiveRecord::Migration[5.1]
  def change
    add_column :deputies, :description, :text
  end
end
