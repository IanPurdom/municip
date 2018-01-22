class AddHeightToCities < ActiveRecord::Migration[5.1]
  def change
    add_column :cities, :height, :string
  end
end
