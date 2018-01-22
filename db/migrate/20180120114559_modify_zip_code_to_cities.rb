class ModifyZipCodeToCities < ActiveRecord::Migration[5.1]
  def change
    change_column :cities, :zip_code, :string
  end
end
