class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.references :questionnaire, foreign_key: true
      t.text :question

      t.timestamps
    end
  end
end
