class RenameAnswersToQuestionToAnswers < ActiveRecord::Migration[5.1]
  def change
    rename_table :answers_to_questions, :answers
  end
end
