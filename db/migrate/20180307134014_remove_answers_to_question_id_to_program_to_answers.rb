class RemoveAnswersToQuestionIdToProgramToAnswers < ActiveRecord::Migration[5.1]
  def change
    remove_column :program_to_answers, :answers_to_question_id, :reference
  end
end
