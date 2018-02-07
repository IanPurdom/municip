class CreateQuestionnaires < ActiveRecord::Migration[5.1]
  def change
    create_table :questionnaires do |t|
      t.string :title
      t.references :category, foreign_key: true
      t.integer :root_question_id

      t.timestamps
    end
  end
end
