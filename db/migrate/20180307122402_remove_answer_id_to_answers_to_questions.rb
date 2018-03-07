class RemoveAnswerIdToAnswersToQuestions < ActiveRecord::Migration[5.1]
  def change
    remove_reference :answers_to_questions, :answer, foreign_key: true
  end
end
