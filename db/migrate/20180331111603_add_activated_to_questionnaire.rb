class AddActivatedToQuestionnaire < ActiveRecord::Migration[5.1]
  def change
    add_column :questionnaires, :activated, :boolean
  end
end
