class AddWebsiteToCities < ActiveRecord::Migration[5.1]
  def change
    add_column :cities, :website, :string
  end
end
