class AddFamilyToDeputies < ActiveRecord::Migration[5.1]
  def change
    add_column :deputies, :family, :string
  end
end
