class AddNametoCity < ActiveRecord::Migration[5.1]
  def change
    add_column :cities, :name, :string, null: false
  end
end
