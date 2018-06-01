class AddColumnsToIntercommunalites < ActiveRecord::Migration[5.1]
  def change
    add_column :intercommunalites, :repartition_siege, :string
    add_column :intercommunalites, :nature_juridique, :string
    add_column :intercommunalites, :financement, :string
    add_column :intercommunalites, :siege, :string
    add_column :intercommunalites, :group_interdept, :string
    add_column :intercommunalites, :date_creation, :string
    add_column :intercommunalites, :nombre_membres, :string
    add_column :intercommunalites, :population, :string
    add_column :intercommunalites, :nombre_competences, :string
    add_column :intercommunalites, :president, :string
    add_column :intercommunalites, :competences, :text, array: true, default: []
  end
end
