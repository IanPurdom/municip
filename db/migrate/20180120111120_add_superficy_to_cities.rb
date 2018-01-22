class AddSuperficyToCities < ActiveRecord::Migration[5.1]
  def change
    add_column :cities, :superficy, :string
  end
end
