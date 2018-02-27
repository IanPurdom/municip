class AddAddressToDeputies < ActiveRecord::Migration[5.1]
  def change
    add_column :deputies, :address, :string
  end
end
