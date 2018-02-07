class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.text :answer
      t.integer :next_question_id

      t.timestamps
    end
  end
end
