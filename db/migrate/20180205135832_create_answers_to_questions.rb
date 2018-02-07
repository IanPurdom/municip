class CreateAnswersToQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :answers_to_questions do |t|
      t.references :question, foreign_key: true
      t.references :answer, foreign_key: true

      t.timestamps
    end
  end
end
