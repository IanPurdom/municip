class AddAnswerToAnswersToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :answers_to_questions, :answer, :string
  end
end
