class CreateProgramToAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :program_to_answers do |t|
      t.references :program, foreign_key: true
      t.references :answers_to_question, foreign_key: true

      t.timestamps
    end
  end
end
