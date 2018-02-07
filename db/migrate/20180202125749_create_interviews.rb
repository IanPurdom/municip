class CreateInterviews < ActiveRecord::Migration[5.1]
  def change
    create_table :interviews do |t|
      t.references :user, foreign_key: true
      t.references :questionnaire, foreign_key: true
      t.integer :last_question_id

      t.timestamps
    end
  end
end
