class AddOrderToQuestionnaires < ActiveRecord::Migration[5.1]
  def change
    add_column :questionnaires, :order, :integer
  end
end
